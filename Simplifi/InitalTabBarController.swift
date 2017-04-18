//
//  InitalTabBarController.swift
//  Simplifi
//
//  Created by Jordan Rader on 2/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class InitialTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0, green: 0.78, blue: 0.33, alpha: 1)
        super.viewWillAppear(true)
//        print(UserDefaults.standard.string(forKey: "user_auth_token"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
}
