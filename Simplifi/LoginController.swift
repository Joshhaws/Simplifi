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
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var passwordInput: UITextField!

    
    override func viewDidLoad() {
        setupView()
        let preferences = UserDefaults.standard
        
    }
    
    func setupView(){
        self.loginForm.layer.cornerRadius = 20.0
        self.loginButton.layer.cornerRadius = 15.0
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if emailInput.text == "" || passwordInput.text == "" {
            //test input fields
            if emailInput.text == "" && passwordInput.text == "" {
                emailError.text = "Please enter a vaild email"
                passwordError.text = "Please enter a password"
            } else if emailInput.text == "" {
                emailError.text = "Please enter a vaild email"
            } else {
                passwordInput.text = "Please enter a password"
            }
        } else {
//            UserDefaults.standard.set("valid", forKey: SyncHelper.Constants.sessionTokenKey)
//            UserDefaults.standard.synchronize()
            SyncHelper.Constants.sessionTokenKey = "valid"
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    
}
