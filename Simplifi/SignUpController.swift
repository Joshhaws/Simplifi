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
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView(){
        self.signupForm.layer.cornerRadius = 2.0
        self.signupButton.layer.cornerRadius = 2.0
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        
        if firstNameTextField.text != "" && lastNameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
            if passwordTextField.text != passwordConfTextField.text {
                errorLabel.text = "Password needs to match"
            } else {
                signupRouter.signup(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password1: passwordTextField.text!, password2: passwordConfTextField.text!, completion: { success in
                    if !success {
                        let anim = CAKeyframeAnimation(keyPath: "transform")
                        anim.values = [
                            NSValue(caTransform3D: CATransform3DMakeTranslation(-5,0,0)),
                            NSValue(caTransform3D: CATransform3DMakeTranslation(5,0,0))
                        ]
                        anim.autoreverses = true
                        anim.repeatCount = 2
                        anim.duration = 7/100
                        self.view.layer.add(anim, forKey: nil)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                
                
            }
        }
    }
    
    
}
