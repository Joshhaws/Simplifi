//
//  Goals.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/4/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox

struct Goals {
    var goalId = 0
    var goalName = ""
    var goalAmount = 0.00
    
    init () {}
    
    init(goalId: Int, goalName: String, amount: Double) {
        self.goalId = goalId
        self.goalName = goalName
        self.goalAmount = amount
    }
    
}

extension Goals : Unboxable{
    init(unboxer: Unboxer) throws {
        do {
            self.goalId = try unboxer.unbox(key: "id")
            self.goalName = try unboxer.unbox(key: "goal_name")
            self.goalAmount = try unboxer.unbox(key: "goal_amount")
        } catch {
            print("ended")
        }
    }
}
