//
//  networkingResources.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/4/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class networkingResources {
    
    static let shared = networkingResources()

    let headers : HTTPHeaders = [
        "X-Mashape-Key": "\(UserDefaults.standard.value(forKey: "user_auth_token"))",
        "Accept": "application/json"
    ]
    
    func getUsers(completion: @escaping ( _ users: [User]) -> Void){
        Alamofire.request(urlData.urlResources.usersUrl).responseJSON { response in
            do{
                guard let data = response.data else { return }
                let users : [User] = try unbox(data: data)
                print(users)
                completion(users)
            }catch{
                print(response.error as Any)
            }
        }
    }
    
    func getEnvelopes() -> [Envelopes]{
        Alamofire.request(urlData.urlResources.envelopesUrl, headers: headers).responseJSON { response in
            do{
                guard let data = response.data else { return }
                let envelopes : [Envelopes] = try unbox(data: data)
                print(envelopes)
                completion(envelopes)
            }catch{
                print(response.error as Any)
            }
        }
    }
    
    
    
    func login(email: String, password: String) -> LoginData {
        
        let parameters : [String: Any] = [
            "email" : "\(email)",
            "password" : "\(password)"
        ]
        
        var login = LoginData()
        
        Alamofire.request("https://simplifiapi.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                do {
                    guard let data = response.data else {return}
                    login = try unbox(data: data)
                    debugPrint(login)
                    
                } catch {
                    print(response.debugDescription as Any)
                }
        }
        return login
    }
        
    
}


