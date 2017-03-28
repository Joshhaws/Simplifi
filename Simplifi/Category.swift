//
//  Category.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/4/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct Category {
    var categoryId = 0
    var name = ""
    var amount = 0.00
    var envelopeId = 0
    
    init() {}
    
    init(categoryId : Int, name: String, amount: Double, envelopeId: Int) {
        self.categoryId = categoryId
        self.name = name
        self.amount = amount
        self.envelopeId = envelopeId
    }
}

extension Category : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.categoryId = try unboxer.unbox(key: "id")
            self.name = try unboxer.unbox(key: "name")
            self.amount = try unboxer.unbox(key: "amount")
            self.envelopeId = try unboxer.unbox(key: "envelope_id")
        }catch{
            print("ended")
        }
    }
    
}
