//
//  accountsRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class accountRouter {
    
    struct accountsResource {
        static let url = urlData.urlResources.accountsUrl
        static let token = UserDefaults.standard.value(forKey: "user_auth_key")
        static let headers: HTTPHeaders = [
            "Authorization": "Token token=1xiLYo9rXFhWXstGi3F0QAtt",
            "Content-Type": "application/json"
        ]
    }
    
    class func getGoals(completion: @escaping (_ accounts: [Account]) -> Void) {
        Alamofire.request(accountsResource.url, headers: accountsResource.headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let accounts: [Account] = try unbox(data: jsonData)
                debugPrint(accounts)
                completion(accounts)
            } catch {
                print("Unable to read JSON, no categories exists\n \(error.localizedDescription)")
            }
        }
    }
}
