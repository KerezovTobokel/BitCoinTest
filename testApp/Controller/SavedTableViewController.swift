//
//  SavedTableViewController.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import RealmSwift

class SavedTableViewController: UITableViewController {

    var bitCoin = [BitCoin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXIB()
        self.navigationItem.title = "Saved"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getBitCoin()
    }
    
    
    func getBitCoin() {
        self.bitCoin.removeAll()
        let bitCoin = RealmManager.instance.getSavedBitCoin()
        for bit in bitCoin {
            self.bitCoin.append(bit)
        }
        self.tableView.reloadData()
    }
    
    func registerXIB(){
        tableView.register(BitCoinTableViewCell.nib, forCellReuseIdentifier: BitCoinTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bitCoin.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BitCoinTableViewCell.identifier, for: indexPath) as! BitCoinTableViewCell
        cell.bitCoin = bitCoin[indexPath.row]
        cell.delegate = self
        cell.getBitCoin()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: Constant.MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "AboutBitCoinTableViewController") as! AboutBitCoinTableViewController
        vc.bitCoin = bitCoin[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}


extension SavedTableViewController: BitCoinTableVCDelegate {
    func saveButton(bitcoin: BitCoin) {
        if bitcoin.saved {
            RealmManager.instance.saveBitCoin(bitCoin: bitcoin, saved: false)
        } else {
            RealmManager.instance.saveBitCoin(bitCoin: bitcoin, saved: true)
        }
        self.tableView.reloadData()
    }
}
