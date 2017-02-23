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
    var transactions : [Transactions] = [Transactions()]
    
    init(){}
    
    init (name: String, amount: Double, transactions: [Transactions]){
        self.name = name
        self.amount = amount
        self.transactions = transactions
    }
    
}
