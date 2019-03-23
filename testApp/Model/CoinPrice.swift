//
//  CoinPrice.swift
//  testApp
//
//  Created by Tobi on 3/23/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class CoinPrice: Object, Mappable {

    @objc dynamic var USD: CoinUSD?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        USD <- map["USD"]
    }
}
