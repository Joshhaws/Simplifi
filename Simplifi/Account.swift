//
//  Account.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/4/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct Account {
    var accountId = 0
    var institutionName = ""
    var accountType = ""
    var accountUserName = ""
    var accountPassword = ""
    
    init() {}
    
    init (accountId: Int, institutionName: String, accountType: String, accountUserName: String, accountPassword: String) {
        self.accountId = accountId
        self.institutionName = institutionName
        self.accountType = accountType
        self.accountUserName = accountUserName
        self.accountPassword = accountPassword
    }
}

extension Account : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.accountId = try unboxer.unbox(key: "id")
            self.institutionName = try unboxer.unbox(key: "institution_name")
            self.accountType = try unboxer.unbox(key: "account_type")
            self.accountUserName = try unboxer.unbox(key: "account_username")
            self.accountPassword = try unboxer.unbox(key: "account_password")
        } catch {
            print("ended")
        }
    }
}
