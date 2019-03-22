//
//  AboutBitCoinTableViewController.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit

class AboutBitCoinTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var slugLabel: UILabel!
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var numlabel: UILabel!
    @IBOutlet weak var cmcLabel: UILabel!
    
    var bitCoin: BitCoin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.bitCoin?.name
        tableView.tableFooterView = UIView(frame: .zero)
        self.getInfo()
    }

    func getInfo() {
        if let bitcoin = self.bitCoin {
            self.nameLabel.text = bitcoin.name
            self.symbolLabel.text = bitcoin.symbol
            self.slugLabel.text = bitcoin.slug
            self.supplyLabel.text = String(bitcoin.circulating_supply)
            self.totalLabel.text = String(bitcoin.total_supply)
            self.numlabel.text = String(bitcoin.num_market_pairs)
            self.cmcLabel.text = String(bitcoin.cmc_rank)
            
        }
    }
}
