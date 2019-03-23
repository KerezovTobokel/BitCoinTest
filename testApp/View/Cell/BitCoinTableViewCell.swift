//
//  BitCoinTableViewCell.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
protocol BitCoinTableVCDelegate: class {
    func saveButton(bitcoin: BitCoin)
}

class BitCoinTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    var bitCoin: BitCoin?
    var delegate: BitCoinTableVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func getBitCoin() {
        if let bitcoin = self.bitCoin{
            self.nameLabel.text = "\(bitcoin.name)"
            if let quote = bitcoin.quote, let USD = quote.USD {
                let price = String(USD.price)
                let price1 = String(price.characters.prefix(7))
                self.priceLabel.text = "$\(price1)"
                if USD.percent_change_24h < 0 {
                    self.priceLabel.textColor = UIColor.red
                } else {
                    self.priceLabel.textColor = UIColor.green
                }
            }
            if bitcoin.saved {
                self.saveButton.setTitle("saved", for: .normal)
                self.saveButton.backgroundColor = Constant.greyColor
                self.saveButton.layer.cornerRadius = 5
            } else {
                self.saveButton.setTitle("save", for: .normal)
                self.saveButton.backgroundColor = Constant.darkRedColor
                self.saveButton.layer.cornerRadius = 5
            }
        }
        
    }
    
    @IBAction func saveBitCoin(_ sender: Any) {
        if let delegate = self.delegate, let bitcoin = self.bitCoin {
            delegate.saveButton(bitcoin: bitcoin)
        }
    }
}
