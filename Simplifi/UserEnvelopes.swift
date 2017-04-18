//
//  UserEnvelopes.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/10/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct UserEnvelopes {
    
    var envelopeId = 0
    var name = ""
    var amount = 0
    var envelopeAmountSpent = 0
    var envelopeAmountLeft = 0
    var userEnvelopeTransactions: [Transactions] = []
    
    init (){}
    
    init (envelopeId: Int, name: String, amount: Int, envelopeAmountSpent: Int, transactions: [Transactions]){
        self.envelopeId = envelopeId
        self.name = name
        self.amount = amount
        self.envelopeAmountSpent = envelopeAmountSpent
        self.userEnvelopeTransactions = transactions
    }
    
}

extension UserEnvelopes : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.envelopeId = try unboxer.unbox(key: "id")
            self.name = try unboxer.unbox(key: "envelope_name")
            self.amount = try unboxer.unbox(key: "amount")
            self.envelopeAmountSpent = try unboxer.unbox(key: "envelope_amount_spent")
            self.envelopeAmountLeft = try unboxer.unbox(key: "enevelope_amount_left")
            self.userEnvelopeTransactions = try unboxer.unbox(key: "user_envelope_transactions")
        } catch {
            print("Unable to parse Envelope details")
        }
    }
}

