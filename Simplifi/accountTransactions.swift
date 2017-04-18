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
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")
    }
    
    
    class func setCategoryForTransaction(categoryId: Int, transactionId: Int, completion: @escaping (_ success: Bool) -> Void){
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        
        Alamofire.request("\(accountTransactionsResources.url)/\(transactionId)", method: .put, parameters: ["category_id" : categoryId], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else{ return }
                let _ : UserEnvelopes = try unbox(data: jsonData)
                completion(true)
            } catch{
                completion(false)
                print("Unable to read JSON, no profile exists\n \(error.localizedDescription)")
            }
        }
    }
    
    
    
    class func getGoals(completion: @escaping (_ accountTransactions: [Transactions]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(accountTransactionsResources.url, headers: headers).responseJSON { response in
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
