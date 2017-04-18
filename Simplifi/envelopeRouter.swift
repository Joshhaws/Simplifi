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
        static let url = urlData.urlResources.userEnvelopeUrl
        static let getBasicEnvelopeUrl = urlData.urlResources.basicEnvelopesUrl
        static let token = UserDefaults.standard.string(forKey: "user_auth_token")

    }
    
    class func getEnvelopes(completion: @escaping (_ envelopes: [UserEnvelopes]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(envelopeResource.url, headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let envelopes: [UserEnvelopes] = try unbox(data: jsonData)
                completion(envelopes)
            } catch {
                print("Unable to read JSON, no envelopes exists\n \(error.localizedDescription)")
            }
        }
    }
    
    class func getEnvelopeForId(id: Int, completion: @escaping (_ envelope: UserEnvelopes) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request("\(envelopeResource.url)/\(id)", headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let envelope: UserEnvelopes = try unbox(data: jsonData)
                completion(envelope)
            } catch {
                print("Unable to read JSON, envelope with that ID doesn't exist\n \(error.localizedDescription)")
            }
        }
    }
    
    class func getEnvelopeBasic(completion: @escaping (_ envelopes: [EnvelopeBasic]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        Alamofire.request(envelopeResource.getBasicEnvelopeUrl, headers: headers).responseJSON { response in
            do{
                guard let jsonData = response.data else {return}
                let envelopes: [EnvelopeBasic] = try unbox(data: jsonData)
                completion(envelopes)
            } catch {
                print("Unable to read JSON, no envelopes exists\n \(error.localizedDescription)")
            }
        }
    }
    
    
    class func setEnvelopeAmount(amount: Int, envelopeId: Int, completion: @escaping (_ success: Bool) -> Void){
        let headers: HTTPHeaders = [
            "Authorization": "Token token=\(UserDefaults.standard.string(forKey: "user_auth_token")!)",
            "Content-Type": "application/json"
        ]
        
        print("\(envelopeResource.url)/\(envelopeId)")
        Alamofire.request("\(envelopeResource.url)/\(envelopeId)", method: .put, parameters: ["amount" : amount], encoding: JSONEncoding.default, headers: headers).responseJSON { response in
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

    
}
