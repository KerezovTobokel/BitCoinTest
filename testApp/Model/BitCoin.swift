//
//  BitCoin.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class BitCoin: Object, Mappable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var saved: Bool = false
    @objc dynamic var slug: String = ""
    @objc dynamic var circulating_supply: Int = 0
    @objc dynamic var total_supply: Int = 0
    @objc dynamic var num_market_pairs: Int = 0
    @objc dynamic var cmc_rank: Int = 0
    
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        symbol <- map["symbol"]
        slug <- map["slug"]
        circulating_supply <- map["symbol"]
        total_supply <- map["symbol"]
        num_market_pairs <- map["num_market_pairs"]
        cmc_rank <- map["cmc_rank"]
        
        
    }
    
}
