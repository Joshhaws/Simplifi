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
        var envelopes = [Envelopes]()
        Alamofire.request(urlData.urlResources.envelopesUrl, headers: headers).responseJSON { response in
            do{
                guard let data = response.data else { return }
                envelopes = try unbox(data: data)
                print(envelopes)
            }catch{
                print(response.error as Any)
            }
        }
        return envelopes
    }
    
    
    func login(email: String, password: String) -> LoginData {
        
        let parameters : [String: Any] = [
            "email" : "\(email)",
            "password" : "\(password)"
        ]
        
        var login = LoginData()
        
        Alamofire.request(urlData.urlResources.loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
    
    func getGoals() -> [Goals] {
        var goals = [Goals]()
        Alamofire.request(urlData.urlResources.goalsUrl, headers: headers).responseJSON { response in
            do{
                guard let data = response.data else { return }
                goals = try unbox(data: data)
                print(goals)
            } catch {
                print(response.error as Any)
            }
        }
        return goals
    }
    
    func getCategories() -> [Category] {
        var categories = [Category]()
        
        Alamofire.request(urlData.urlResources.categoriesUrl, headers: headers).responseJSON { response in
            do{
                guard let data = response.data else { return }
                categories = try unbox(data: data)
                print(categories)
            }catch{
                print(response.error as Any)
            }
        }
        return categories
    }
    
    func getAccounts() -> [Account] {
        var accounts = [Account]()
        
        Alamofire.request(urlData.urlResources.categoriesUrl, headers: headers).responseJSON { response in
            do{
                guard let data = response.data else { return }
                accounts = try unbox(data: data)
                print(accounts)
            }catch{
                print(response.error as Any)
            }
        }
        return accounts
    }
    
    
}


