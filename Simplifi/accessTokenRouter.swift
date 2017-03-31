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
        Alamofire.request(accessTokenResources.url, method: .post, parameters: ["token" : token], encoding: JSONEncoding.default).responseJSON { response in
            do{
                
            } catch{
                print("Unable to read JSON, no profile exists\n \(error.localizedDescription)")
            }
        }
    }

}
