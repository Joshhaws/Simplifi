//
//  EnvelopeMini.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/8/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct EnvelopeMini {
    
    var id = 0
    var name = ""
    
    init (){}
    
}

extension EnvelopeMini : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.name = try unboxer.unbox(key: "name")
            self.id = try unboxer.unbox(key: "id")
        } catch {
            print("Unable to parse Envelope Mini")
        }
    }

}
