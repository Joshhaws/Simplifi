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
        static let token = UserDefaults.standard.value(forKey: "user_auth_key")
        static let headers: HTTPHeaders = [
            "Authorization": "Token token=1xiLYo9rXFhWXstGi3F0QAtt",
            "Content-Type": "application/json"
        ]
    }
    
    class func getCategories(completion: @escaping (_ categories: [Category]) -> Void) {
        Alamofire.request(categoriesResource.url, headers: categoriesResource.headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let categories: [Category] = try unbox(data: jsonData)
                debugPrint(categories)
                completion(categories)
            } catch {
                print("Unable to read JSON, no categories exists\n \(error.localizedDescription)")
            }
        }
    }
}
