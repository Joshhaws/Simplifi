//
//  LoginController.swift
//  Simplifi
//
//  Created by Joshua Haws on 1/27/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var loginForm: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView(){
        self.loginForm.layer.cornerRadius = 20.0
        self.loginButton.layer.cornerRadius = 15.0
    }
}
