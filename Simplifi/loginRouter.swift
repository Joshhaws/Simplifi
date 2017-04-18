//
//  loginRouter.swift
//  Simplifi
//
//  Created by Joshua Haws on 2/3/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class loginRouter {
    
    
    class func attemptLogin(userEmail: String, userPassword: String, completion: @escaping (_ success: Bool) -> Void){
        Alamofire.request(urlData.urlResources.loginUrl, method: .post, parameters: ["email" : userEmail, "password" : userPassword], encoding: JSONEncoding.default).responseJSON { response in
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
                    
                    SyncHelper.Constants.sessionTokenKey = login.token
                    SyncHelper.Constants.userIDKey = login.userId
                    SyncHelper.Constants.userFirstName = login.firstName
                    SyncHelper.Constants.userLastName = login.lastName
                    SyncHelper.Constants.userEmail = login.email
                    completion(true)
                }
            } catch{
                completion(false)
                print("Unable to read JSON, no profile exists\n \(error.localizedDescription)")
            }
        }
    }
}
