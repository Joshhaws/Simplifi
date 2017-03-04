//
//  Envelopes.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/15/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

class Envelopes {
    var name = ""
    var amount = 0.00
    var accountId = 0
    var categoryId = 0
    
    
    init(){}
    
    init (name: String, amount: Double, accountId: Int, categoryId: Int){
        self.name = name
        self.amount = amount
        self.accountId = accountId
        self.categoryId = categoryId
    }
    
}
