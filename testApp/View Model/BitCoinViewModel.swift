//
//  BitCoinViewModel.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class BitCoinViewModel: NSObject {
    
    func getBitCoin(onCompletion: @escaping (([BitCoin]) -> Void), onError: @escaping ((String?) -> Void)){
        ServiceManager.instance.getBitCoin(onCompletion: { (bitcoin) in
            onCompletion(bitcoin)
        }) { (error) in
            onError(error!)
        }
    }
    
    func downloadBitCoin(coins: Int, onCompletion: @escaping (([BitCoin]) -> Void), onError: @escaping ((String?) -> Void)){
        ServiceManager.instance.downloadBitCoin(coins: coins, onCompletion: { (bitcoin) in
            onCompletion(bitcoin)
        }) { (error) in
            onError(error!)
        }
    }
}
