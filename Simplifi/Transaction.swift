//
//  Transaction.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/15/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

class Transaction {
    var storeName = ""
    var totalCost = 0.0
    var transDate = Date()
    
    init(){}
    
    init(store: String, cost: Double, date: Date) {
        self.storeName = store
        self.totalCost = cost
        self.transDate = date
    }
}
