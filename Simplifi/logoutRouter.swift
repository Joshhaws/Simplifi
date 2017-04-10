//
//  logoutRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/8/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class logoutRouter {
    struct logoutResources {
        static let url = urlData.urlResources.logoutUrl
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")
        static let headers: HTTPHeaders = [
            "Authorization": "Token token=\(logoutResources.token!)",
            "Content-Type": "application/json"
        ]
    }
    
    class func logout(completion: @escaping () -> Void) {
        Alamofire.request(logoutResources.url, headers: logoutResources.headers).responseJSON { response in
            UserDefaults.standard.set(nil, forKey: "user_auth_token")
            UserDefaults.standard.set(nil, forKey: "user_id")
            UserDefaults.standard.set(nil, forKey: "user_firstName")
            UserDefaults.standard.set(nil, forKey: "user_lastName")
            UserDefaults.standard.set(nil, forKey: "user_email")
            UserDefaults.standard.synchronize()
        }
    }
}
