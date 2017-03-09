//
//  Transactions.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/21/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

import Foundation

struct Transactions {
    var totalCost = 0.0
    var transDate = ""
    var lineItems : [TransactionItem] = [TransactionItem()]
    
    init(){}
    
    init(cost: Double, date: String, lineItems: [TransactionItem]) {
        self.totalCost = cost
        self.transDate = date
        self.lineItems = lineItems
    }
}

extension Transactions: Unboxable{
    init(unboxer: Unboxer) throws {
        do {
            self.totalCost = try unboxer.unbox(key: "last_name")
            self.transDate = try unboxer.unbox(key: "transaction_date")
            self.lineItems = try unboxer.unbox(key: "line_items")
        }catch{
            print("Unable to unbox data")
        }
    }
}
