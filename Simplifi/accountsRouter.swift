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
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")

    }
    
    class func getAccounts(completion: @escaping (_ accounts: [Account]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(accountsResource.url, headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let accounts: [Account] = try unbox(data: jsonData)
                completion(accounts)
            } catch {
                print("Unable to read JSON, no accounts exists\n \(error.localizedDescription)")
            }
        }
    }
}
