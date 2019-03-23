//
//  CoinUSD.swift
//  testApp
//
//  Created by Tobi on 3/23/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class CoinUSD: Object, Mappable {
    
    @objc dynamic var price: Double = 0.0
    @objc dynamic var percent_change_24h: Double = 0.0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        price <- map["price"]
        percent_change_24h <- map["percent_change_24h"]
    }
}
