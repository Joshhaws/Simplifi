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
//    account_id
//    amount
//    category_id
//    location
//    address
//    city
//    state
//    zip
//    name
    var accountId = ""
    var amount = 0.0
    var categoryId = 0
    var storeName = ""
    var transDate = ""
    var testAccountName = ""
    var categoryName = ""
    //    var lineItems : [TransactionItem] = [TransactionItem()]
    
    init(){}
    
    init(cost: Double, date: String, categoryId: Int) {
        self.amount = cost
        self.transDate = date
        self.categoryId = categoryId
        //        self.lineItems = lineItems
    }
}

extension Transactions: Unboxable{
    init(unboxer: Unboxer) throws {
        do {
            self.amount = try unboxer.unbox(key: "amount")
            self.transDate = try unboxer.unbox(key: "transaction_date")
//            self.categoryId = try unboxer.unbox(keyPath: "category_id")
//            self.accountId = try unboxer.unbox(key: "account_id")
//            self.storeName = try unboxer.unbox(key: "name")
            self.testAccountName = try unboxer.unbox(key: "account_name")
            self.categoryName = try unboxer.unbox(key: "category_name")
//            self.lineItems = try unboxer.unbox(key: "line_items")
        }catch{
            print("Unable to unbox data for Transaction Data")
        }
    }
}
