//
//  SignUpController.swift
//  Simplifi
//
//  Created by Joshua Haws on 1/31/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    
    @IBOutlet weak var signupForm: UIView!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView(){
        self.signupForm.layer.cornerRadius = 20.0
        self.signupButton.layer.cornerRadius = 15.0
    }
}
