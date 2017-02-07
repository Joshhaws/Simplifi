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

class loginRouter{
    
    private struct loginResource{
        static let baseUrl = "https://simplifiapi.herokuapp.com/users"
//        static let header: HTTPHeaders = {
//            "value": "key",
//        }
        
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
