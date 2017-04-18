//
//  LoginData.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/1/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct LoginData {
    var token = ""
    var firstName = ""
    var lastName = ""
    var userId = 0
    var email = ""
    
    init() {}
    
    init(token: String, firstName: String, lastName: String){
        self.token = token
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension LoginData: Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.firstName = try unboxer.unbox(key: "first_name")
            self.lastName = try unboxer.unbox(key: "last_name")
            self.token = try unboxer.unbox(key: "token")
            self.userId = try unboxer.unbox(key: "id")
            self.email = try unboxer.unbox(key: "email")
        }catch{
            print("Unable to unbox data for Login Data")
        }
    }
}
