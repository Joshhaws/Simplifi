//
//  TestData.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/22/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

class TestData {
    
    var user = User(firstName: "Jordan", lastName: "Rader", email: "jordan@rader.com")
    var lineItem = TransactionItem(itemName: "Toothpaste", itemTotal: 3.49)
    var transaction = Transactions(store: "Smiths", cost: 3.49, date: Date(), lineItems: [TransactionItem(itemName: "Toothpaste", itemTotal: 3.49)])
    var envelope = Envelopes(name: "Toiletries", amount: 346.75, transactions: [Transactions(store: "Smiths", cost: 3.49, date: Date(), lineItems: [TransactionItem(itemName: "Toothpaste", itemTotal: 3.49)])])
}
