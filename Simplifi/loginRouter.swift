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
                    completion(true)
                }
                completion(false)
            } catch{
                print("Unable to read JSON, no profile exists\n \(error.localizedDescription)")
            }
        }
    }
    
        
//    class func getUsers(completion: @escaping ( _ users: [User]) -> Void){
//        Alamofire.request(loginResource.baseUrl).responseJSON { response in
//            do{
//                guard let data = response.data else { return }
//                let users : [User] = try unbox(data: data)
//                print(users)
//                completion(users)
//            }catch{
//                print(response.error)
//            }
//        }
//    }
    
    

}
