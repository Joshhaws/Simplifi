//
//  User.swift
//  Simplifi
//
//  Created by Joshua Haws on 2/3/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct User {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var userId: Int = 0
//    var password: String
    
    init(firstName: String, lastName: String, email: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
//        self.password = password
    }
}

extension User: Unboxable{
    init(unboxer: Unboxer) throws {
        do {
            self.firstName = try unboxer.unbox(key: "first_name")
            self.lastName = try unboxer.unbox(key: "last_name")
            self.email = try unboxer.unbox(key: "email")
            self.userId = try unboxer.unbox(key: "id")
        }catch{
            print("ended")
        }
    }
}
