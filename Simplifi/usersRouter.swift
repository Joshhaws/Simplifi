//
//  usersRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 4/10/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class usersRouter {
    
    struct usersResource {
        static let url = urlData.urlResources.usersUrl
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")
        static let userId = UserDefaults.standard.string(forKey: "user_id")
    }
    
    class func getUsersWithID(completion: @escaping (_ user: User) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request("\(usersResource.url)/\(UserDefaults.standard.string(forKey: "user_id")!)", headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let thisUser: User = try unbox(data: jsonData)
                completion(thisUser)
            } catch {
                print("Unable to read JSON, no Users exist\n \(error.localizedDescription)")
            }
        }
    }
    
}
