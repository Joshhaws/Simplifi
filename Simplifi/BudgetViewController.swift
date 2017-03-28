//
//  BudgetViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/16/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addSliders() -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 0
        
        return slider
    }
    
}
