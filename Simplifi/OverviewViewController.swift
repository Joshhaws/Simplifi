//
//  OverviewViewController.swift
//  Simplifi
//
//  Created by Jordan Rader on 1/24/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class OverrviewViewController: UIViewController {
    
    var sessionId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sessionId == "" {
            performSegue(withIdentifier: "loginModal", sender: self)
        }
    }
    
}
