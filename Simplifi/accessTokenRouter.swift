//
//  accessTokenRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/30/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

import Unbox
import Alamofire

class accessTokenRouter {
    
    struct accessTokenResources {
        static let url = urlData.urlResources.accessTokenUrl
    }
    
    class func updloadAccessToken(token: String, completion: @escaping (_ success: Bool) -> Void){
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        print("User token: \(token)")
//        Alamofire.request(accessTokenResources.url, method: .post, parameters: ["public_token" : token], encoding: JSONEncoding.default, headers: headers) { response in
//            
//        }
        
        Alamofire.request(accessTokenResources.url, method: .post, parameters: ["public_token" : token], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard response.data != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }

}
