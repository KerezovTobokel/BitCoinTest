//
//  ServiceManager.swift
//  testApp
//
//  Created by Tobi on 3/22/19.
//  Copyright © 2019 com.example. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


let API_KEY  = "https://pro-api.coinmarketcap.com"

class ServiceManager: NSObject {

    static let instance = ServiceManager()
    
    func getBitCoin(onCompletion: @escaping (([BitCoin]) -> Void), onError: @escaping ((String?) -> Void)) {
        let api = "/v1/cryptocurrency/listings/latest"
        let APIaddress =  "\(API_KEY)\(api)"
        
        let headers: HTTPHeaders = [
            "X-CMC_PRO_API_KEY": "71595dae-5a43-4498-8494-225a5c61dd39"
        ]
        
        Alamofire.request(APIaddress, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if self.isSuccessResponse(statusCode: statusCode) {
                    let result = response.result.value as! [String: AnyObject]
                    if let data = result["data"] as? [[String: AnyObject]] {
                        let bitCoin = Mapper<BitCoin>().mapArray(JSONArray: data)
                        onCompletion(bitCoin)
                    }
                } else if self.isErrorResponse(statusCode: statusCode) {
                    let result = response.result.value as! [String: AnyObject]
                    if let errorMessage = result["message"] as? String {
                        onError(errorMessage)
                        return
                    } else {
                        onError("Error")
                        return
                    }
                }
            } else {
                if let error = response.result.error {
                    onError(error.localizedDescription)
                }
            }
        }
    }
    
    func downloadBitCoin(coins: Int, onCompletion: @escaping (([BitCoin]) -> Void), onError: @escaping ((String?) -> Void)) {
        let api = "/v1/cryptocurrency/listings/latest?start=\(coins)&limit=200"
        let APIaddress =  "\(API_KEY)\(api)"
        
        let headers: HTTPHeaders = [
            "X-CMC_PRO_API_KEY": "71595dae-5a43-4498-8494-225a5c61dd39"
        ]
        
        Alamofire.request(APIaddress, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                if self.isSuccessResponse(statusCode: statusCode) {
                    let result = response.result.value as! [String: AnyObject]
                    if let data = result["data"] as? [[String: AnyObject]] {
                        let bitCoin = Mapper<BitCoin>().mapArray(JSONArray: data)
                        onCompletion(bitCoin)
                    }
                } else if self.isErrorResponse(statusCode: statusCode) {
                    let result = response.result.value as! [String: AnyObject]
                    if let errorMessage = result["message"] as? String {
                        onError(errorMessage)
                        return
                    } else {
                        onError("Error")
                        return
                    }
                }
            } else {
                if let error = response.result.error {
                    onError(error.localizedDescription)
                }
            }
        }
    }
    
    
    func isSuccessResponse(statusCode: Int) -> Bool {
        if Constant.success.contains(statusCode) {
            return true
        }
        return false
    }
    
    func isErrorResponse(statusCode: Int) -> Bool {
        if Constant.error.contains(statusCode) {
            return true
        }
        return false
    }
}
