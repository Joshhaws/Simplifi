//
//  AccountTransactions.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/8/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class accountTransactions {
    
    struct accountTransactionsResources {
        static let url = urlData.urlResources.accountTransactionUrl
        static let token = UserDefaults.standard.value(forKey: "user_auth_key")
        static let headers: HTTPHeaders = [
            "Authorization": "Token token=1xiLYo9rXFhWXstGi3F0QAtt",
            "Content-Type": "application/json"
        ]
    }
    
    class func getGoals(completion: @escaping (_ accountTransactions: [Transactions]) -> Void) {
        Alamofire.request(accountTransactionsResources.url, headers: accountTransactionsResources.headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let accountTransactions: [Transactions] = try unbox(data: jsonData)
                debugPrint(accountTransactions)
                completion(accountTransactions)
            } catch {
                print("Unable to read JSON, no categories exists\n \(error.localizedDescription)")
            }
        }
    }
}
