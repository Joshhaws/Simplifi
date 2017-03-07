//
//  Envelopes.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/15/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct Envelopes {
    var name = ""
    var amount = 0.00
    var userId = 0
    var categoryId = 0
    
    init (name: String, amount: Double, userId: Int, categoryId: Int){
        self.name = name
        self.amount = amount
        self.userId = userId
        self.categoryId = categoryId
    }
    
}

extension Envelopes : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.name = try unboxer.unbox(key: "name")
            self.amount = try unboxer.unbox(key: "amount")
            self.userId = try unboxer.unbox(key: "userId")
        } catch {
            print("ended")
        }
    }
}

