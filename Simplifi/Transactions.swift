//
//  Transactions.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/21/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

import Foundation

class Transactions {
    var storeName = ""
    var totalCost = 0.0
    var transDate = Date()
    var lineItems : [TransactionItem] = [TransactionItem()]
    
    init(){}
    
    init(store: String, cost: Double, date: Date) {
        self.storeName = store
        self.totalCost = cost
        self.transDate = date
    }
}
