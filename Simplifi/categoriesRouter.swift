//
//  categoriesRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/7/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class categoriesRouter {
    
    struct categoriesResource {
        static let url = urlData.urlResources.categoriesUrl
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")

    }
    
    class func getCategories(completion: @escaping (_ categories: [Category]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(categoriesResource.url, headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let categories: [Category] = try unbox(data: jsonData)
                completion(categories)
            } catch {
                print("Unable to read JSON, no categories exist\n \(error.localizedDescription)")
            }
        }
    }
}
