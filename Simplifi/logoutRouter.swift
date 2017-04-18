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

    }
    
    class func logout(completion: @escaping () -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(logoutResources.url, headers: headers).responseJSON { response in
            
            let appDomain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
            print("Token: \(UserDefaults.standard.string(forKey: "user_auth_token") as Any)")
        }
    }
}
