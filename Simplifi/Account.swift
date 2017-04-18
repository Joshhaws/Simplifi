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
    var name = ""
    var accountType = ""
    var accountSubtype = ""
    var institutionName = ""

    
    init() {}
    
    init (accountId: Int, name: String, accountType: String, accountSubtype: String, accountPassword: String) {
        self.accountId = accountId
        self.name = name
        self.accountType = accountType
        self.accountSubtype = accountSubtype
    }
}

extension Account : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.accountId = try unboxer.unbox(key: "id")
            self.name = try unboxer.unbox(key: "name")
            self.accountType = try unboxer.unbox(key: "account_type")
            self.accountSubtype = try unboxer.unbox(key: "account_subtype")
            self.institutionName = try unboxer.unbox(key: "institution_name")
        } catch {
            print("Unable to parse data for Accounts")
        }
    }
}
