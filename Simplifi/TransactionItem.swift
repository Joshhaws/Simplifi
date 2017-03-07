//
//  TransactionItem.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/21/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

class TransactionItem {
    
    var itemName = ""
    var itemTotal = 0.00
    
    init () {}
    
    init (itemName: String, itemTotal: Double) {
        self.itemName = itemName
        self.itemTotal = itemTotal
    }
}
