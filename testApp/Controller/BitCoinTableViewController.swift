//
//  BitCoinTableViewController.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit

class BitCoinTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarCoin: UISearchBar!
    
    var bitCoinVM = BitCoinViewModel()
    var bitCoin = [BitCoin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Crypto"
        self.registerXIB()
        self.setupSearchBar()
        self.getBitCoin()
        tableView.tableFooterView = UIView(frame: .zero)
        searchBarCoin.enablesReturnKeyAutomatically = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getFromRealm()
    }
    
    func getFromRealm() {
        self.bitCoin.removeAll()
        let bitCoins = RealmManager.instance.getAllBitCoins()
        for bit in bitCoins {
            self.bitCoin.append(bit)
        }
        self.tableView.reloadData()
    }
    
    func getBitCoin() {
        self.bitCoinVM.getBitCoin(onCompletion: { (bitCoin) in
            self.bitCoin = bitCoin
            RealmManager.instance.writeBitCoin(bitCoin: bitCoin)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error!)
        }
    }
    
    func searchBitCoin(text: String) {
        self.bitCoin.removeAll()
        if text != "" {
            let allBitCoin = RealmManager.instance.getBitCoins(bitCoinName: text)
            for bit in allBitCoin {
                self.bitCoin.append(bit)
            }
        } else {
            let allBitCoin = RealmManager.instance.getAllBitCoins()
            for bit in allBitCoin {
                self.bitCoin.append(bit)
            }
        }
        self.tableView.reloadData()
    }
    
    func setupSearchBar() {
        searchBarCoin.delegate = self
    }
    
    func registerXIB() {
        tableView.register(BitCoinTableViewCell.nib, forCellReuseIdentifier: BitCoinTableViewCell.identifier)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.replacingOccurrences(of: " ", with: "")
        self.searchBitCoin(text: text)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitCoin.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BitCoinTableViewCell.identifier) as! BitCoinTableViewCell
        cell.bitCoin = bitCoin[indexPath.row]
        cell.delegate = self
        cell.getBitCoin()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)     {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: Constant.MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "AboutBitCoinTableViewController") as! AboutBitCoinTableViewController
        vc.bitCoin = bitCoin[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let coins = self.bitCoin.count
        if indexPath.row == coins - 1 {
            self.bitCoinVM.downloadBitCoin(coins: coins, onCompletion: { (bitCoin) in
                self.bitCoin = bitCoin
                RealmManager.instance.writeBitCoin(bitCoin: bitCoin)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }) { (error) in
                print(error!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension BitCoinTableViewController: BitCoinTableVCDelegate {
    func saveButton(bitcoin: BitCoin) {
        if bitcoin.saved {
            RealmManager.instance.saveBitCoin(bitCoin: bitcoin, saved: false)
        } else {
            RealmManager.instance.saveBitCoin(bitCoin: bitcoin, saved: true)
        }
        self.tableView.reloadData()
    }
}
