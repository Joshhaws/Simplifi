//
//  signupRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/21/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class signupRouter {
    
    struct signupResources {
        static let url = urlData.urlResources.usersUrl
    }
    
    class func signup(firstName: String, lastName: String, email: String, password1: String, password2: String, completion: @escaping (_ success: Bool) -> Void){
        
        let parameters = [
            "user": [
                "first_name": "\(firstName)",
                "last_name": "\(lastName)",
                "email": "\(email)",
                "password": "\(password1)",
                "password_confifrmation": "\(password2)"
            ]
        ]
        
        Alamofire.request(urlData.urlResources.signupUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            do{
                guard let jsonData = response.data else{ return }
                let login : LoginData = try unbox(data: jsonData)
                if login.token != "" {
                    UserDefaults.standard.set(login.token, forKey: "user_auth_token")
                    UserDefaults.standard.set(login.userId, forKey: "user_id")
                    UserDefaults.standard.set(login.firstName, forKey: "user_firstName")
                    UserDefaults.standard.set(login.lastName, forKey: "user_lastName")
                    UserDefaults.standard.set(login.email, forKey: "user_email")
                    UserDefaults.standard.synchronize()

                    completion(true)
                }
            } catch{
                completion(false)
                print("Unable to read JSON, Unable to sign up new user\n \(error.localizedDescription)")
            }
        }
    }
    
}
