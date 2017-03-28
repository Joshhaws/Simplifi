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
        static let baseSyncUrl = ""
        static let failureCode = ""
        static let resultKey = "result"
        static var sessionTokenKey = UserDefaults.standard.value(forKey: "user_auth_token")
        static let userIDKey = ""
        static let successResult = "success"
    }
    
    static let shared = SyncHelper()
    
}
