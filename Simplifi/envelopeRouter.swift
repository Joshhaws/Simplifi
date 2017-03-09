//
//  envelopeRouter.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/6/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation
import Unbox
import Alamofire

class envelopeRouter {
    
    struct envelopeResource{
        static let url = urlData.urlResources.envelopesUrl
        static let token = SyncHelper.Constants.sessionTokenKey
        static let headers: HTTPHeaders = [
            "Authorization": "Token token=\(envelopeResource.token!)",
            "Content-Type": "application/json"
        ]
    }
    
    class func getEnvelopes(completion: @escaping (_ envelopes: [Envelopes]) -> Void) {
        Alamofire.request("https://simplifiapi.herokuapp.com/envelopes", headers: envelopeResource.headers).responseJSON { response in
            do{
                print("Headers")
                debugPrint(envelopeResource.headers)
                guard let jsonData = response.data else {return}
                let envelopes: [Envelopes] = try unbox(data: jsonData)
                debugPrint(envelopes)
                completion(envelopes)
            } catch {
                print("Unable to read JSON, no envelopes exists\n \(error.localizedDescription)")
            }
        }
    }
    
}
