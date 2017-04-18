//
//  EnvelopeBasic.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/10/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct EnvelopeBasic {
    var name = ""
    var amount = ""
    
    init() {}
}

extension EnvelopeBasic : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.name = try unboxer.unbox(key: "envelope_name")
            self.amount = try unboxer.unbox(key: "envelope_amount_spent")
        } catch {
            print("Unable to parse Envelope Mini")
        }
    }
    
}
