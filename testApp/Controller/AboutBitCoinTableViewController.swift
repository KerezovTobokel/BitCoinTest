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
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
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
            if let quote = bitcoin.quote, let USD = quote.USD {
                let price = String(USD.price)
                let price1 = String(price.characters.prefix(10))
                self.price.text = "$\(price1)"
                self.percentLabel.text = String("\(USD.percent_change_24h)%")
                if USD.percent_change_24h < 0 {
                    self.price.textColor = UIColor.red
                    self.percentLabel.textColor = UIColor.red
                } else {
                    self.price.textColor = UIColor.green
                    self.percentLabel.textColor = UIColor.green
                }
            }
        }
    }
}
