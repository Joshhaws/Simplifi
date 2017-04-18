//
//  Envelopes.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/15/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct Envelopes {
    var name = ""
    var amount = 0
    var totalSpentEnvelope = 0
    var envelopeId = 0
    var accountTransactions: [Transactions] = []
    
    init (){}
    
    init (name: String, amount: Int, totalSpentEnvelope: Int, id: Int, transactions: [Transactions]){
        self.name = name
        self.amount = amount
        self.totalSpentEnvelope = totalSpentEnvelope
        self.envelopeId = id
        self.accountTransactions = transactions
    }
    
}

extension Envelopes : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.name = try unboxer.unbox(key: "name")
            self.amount = try unboxer.unbox(key: "amount")
            self.totalSpentEnvelope = try unboxer.unbox(key: "total_spent_envelope")
            self.envelopeId = try unboxer.unbox(key: "envelope_id")
            self.accountTransactions = try unboxer.unbox(keyPath: "account_transactions")
        } catch {
            print("Unable to parse Envelope details")
        }
    }
}

