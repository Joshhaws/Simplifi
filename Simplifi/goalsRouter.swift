//
//  goalsResource.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class goalsRouter {
    
    struct goalsResource {
        static let url = urlData.urlResources.goalsUrl
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")
        static let headers: HTTPHeaders = [
            "Authorization": "Token token=\(goalsResource.token)",
            "Content-Type": "application/json"
        ]
    }
    
    class func getGoals(completion: @escaping (_ goals: [Goals]) -> Void) {
        Alamofire.request(goalsResource.url, headers: goalsResource.headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let goals: [Goals] = try unbox(data: jsonData)
                debugPrint(goals)
                completion(goals)
            } catch {
                print("Unable to read JSON, no categories exists\n \(error.localizedDescription)")
            }
        }
    }
}
