//
//  LoginController.swift
//  Simplifi
//
//  Created by Joshua Haws on 1/27/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class LoginController: UIViewController {

    @IBOutlet weak var loginForm: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signupBotton: UIButton!

    
    override func viewDidLoad() {
        setupView()
//        let preferences = UserDefaults.standard
    }
    
    func setupView(){
        self.loginForm.layer.cornerRadius = 2.0
        self.loginButton.layer.cornerRadius = 2.0
        self.signupBotton.layer.cornerRadius = 2.0
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
            
            loginRouter.attemptLogin(userEmail: emailInput.text!, userPassword: passwordInput.text!, completion: { success in
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
                    if let app = UIApplication.shared.delegate as? AppDelegate{
                        app.showMain()
                    }
                }
            })
        }
    }
}
