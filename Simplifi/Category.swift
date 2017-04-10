//
//  Category.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/4/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct Category {
    var categoryId = 0
    var group = ""
    var hierarchy_1 = ""
    var hierarchy_2 = ""
    var hierarchy_3 = ""
    var envelope: EnvelopeMini = EnvelopeMini()
    
    init() {}
    
    
}

extension Category : Unboxable {
    init(unboxer: Unboxer) throws {
        do {
            self.categoryId = try unboxer.unbox(key: "id")
            self.hierarchy_1 = try unboxer.unbox(key: "hierarchy_1")
            self.hierarchy_2 = try unboxer.unbox(key: "hierarchy_2")
            self.hierarchy_3 = try unboxer.unbox(key: "hierarchy_3")
            self.envelope = try unboxer.unbox(key: "envelope")
        } catch {
            print("Unable to unbox data for Categories")
        }
    }
    
}
