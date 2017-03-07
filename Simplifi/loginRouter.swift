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
    
//    private struct loginResource{
//        static let baseUrl = "https://simplifiapi.herokuapp.com/users"
////        static let header: HTTPHeaders = {
////            "value": "key",
////        }
//        
//    }
    
    private struct loginResource {
        static let baseUrl = "https://simplifiapi.herokuapp.com/login"
        //        static let header: HTTPHeaders = {
        //            "value": "key",
        //        }
        
    }
    
    let parameters : [String: Any] = [
        "email" : "joshhaws0@gmail.com",
        "password" : "example1"
    ]

    
    
    func login (credentials: [String: Any]) {
        Alamofire.request(loginResource.baseUrl, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                do {
                    guard let data = response.data else {return}
                    let user : User = try unbox(data: data)
                    print(user)
                } catch {
                    print(response.error!)
                }
        }
    }
    
    class func getUsers(completion: @escaping ( _ users: [User]) -> Void){
        Alamofire.request(loginResource.baseUrl).responseJSON { response in
            do{
                guard let data = response.data else { return }
                let users : [User] = try unbox(data: data)
                print(users)
                completion(users)
            }catch{
                print(response.error)
            }
        }
    }
    
    

}
