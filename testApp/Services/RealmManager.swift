//
//  RealmManager.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager: NSObject {
    
    static let instance = RealmManager()
    
    let realm = try! Realm()
    
    func writeBitCoin(bitCoin: [BitCoin]){
        if bitCoin.count != 0 {
            do {
                try realm.write {
                    realm.add(bitCoin, update: true)
                }
            } catch (let error){
                print("Error writeCoin: \(error.localizedDescription)")
            }
        }
    }
    
    
    func getAllBitCoins() -> Results<BitCoin> {
        return realm.objects(BitCoin.self)
    }
    
    
    func getBitCoins(bitCoinName: String) -> Results<BitCoin> {
        if bitCoinName.isEmpty{
            return realm.objects(BitCoin.self)
        }else{
            let predicate = NSPredicate(format: "name contains[c] %@", bitCoinName)
            return realm.objects(BitCoin.self).filter(predicate)
        }
    }
    
    func saveBitCoin(bitCoin: BitCoin, saved: Bool){
        do {
            try realm.write {
                bitCoin.saved = saved
                realm.add(bitCoin, update: true)
            }
        } catch (let error){
            print("Error writeCoin: \(error.localizedDescription)")
        }
    }
    
    func getSavedBitCoin() -> Results<BitCoin>{
        let savedBitCoin = realm.objects(BitCoin.self).filter("saved == true")
        return savedBitCoin
    }
}
