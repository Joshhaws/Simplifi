//
//  SyncHelper.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/8/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class SyncHelper {
    
    struct Constants {
        static let resultKey = "result"
        static var sessionTokenKey = UserDefaults.standard.value(forKey: "user_auth_token")
        static var userIDKey = UserDefaults.standard.value(forKey: "user_id")
        static var userFirstName = UserDefaults.standard.string(forKey: "user_firstName")
        static var userLastName = UserDefaults.standard.string(forKey: "user_lastName")
        static var userEmail = UserDefaults.standard.string(forKey: "user_email")
        static var userArray = ["\(String(describing: userFirstName)) \(String(describing: userLastName))", "\(String(describing: userEmail))"]
        
        
        static let plaidApiKey = "4181b5e7e3476f2974824d3a1d4e52"
    }
    
    static let shared = SyncHelper()
    
}
