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

//    "id": 80,
//    "transaction_id": "EpBXGZLnA8UQ7XwzyadLTmXv5lldZEijmM19Z",
//    "amount": 12,
//    "transaction_type": "place",
//    "date": "2017-03-29T00:00:00.000Z",
//    "pending": false,
//    "pending_transaction_id": null,
//    "address": null,
//    "city": null,
//    "state": null,
//    "zip": null,
//    "lat": null,
//    "lon": null,
//    "name": "McDonald's",
//    "category_id": 13005032,
//    "account_id": 61,
//    "created_at": "2017-04-05T23:15:13.000Z",
//    "updated_at": "2017-04-05T23:15:13.000Z",
//    "user_id": 2
    
    var transactionId = 0
    var amount = 0.0
    var transactionType = ""
    var date = ""
    var storeName = ""
    var categoryId = 0
    var accountId = 0
    
    
    init(){}
    
//    init(cost: Double, date: String, categoryId: Int) {
//        self.amount = cost
//        self.transDate = date
//        self.categoryId = categoryId
//        //        self.lineItems = lineItems
//    }
}

extension Transactions: Unboxable{
    init(unboxer: Unboxer) throws {
        do {
            self.transactionId = try unboxer.unbox(key: "id")
            self.amount = try unboxer.unbox(key: "amount")
            self.transactionType = try unboxer.unbox(key: "transaction_type")
            self.date = try unboxer.unbox(key: "date")
            self.storeName = try unboxer.unbox(key: "name")
            self.categoryId = try unboxer.unbox(key: "category_id")
            self.accountId = try unboxer.unbox(key: "account_id")

        }catch{
            print("Unable to unbox data for Transaction Data")
        }
    }
}
