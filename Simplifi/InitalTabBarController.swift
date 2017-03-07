//
//  InitalTabBarController.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class InitialTabBarController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if ((UserDefaults.standard.value(forKey: "user_auth_token") == nil)) {
            performSegue(withIdentifier: "loginModalSegue", sender: self)
        } else {
            print(UserDefaults.standard.value(forKey: "user_auth_token")!)
        }
    }
}
