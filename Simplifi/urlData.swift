//
//  urlData.swift
//  Simplifi
//
//  Created by Jordan Rader on 3/4/17.
//  Copyright © 2017 Joshua Haws. All rights reserved.
//

import Foundation

class urlData {
    
    struct urlResources {
        static let loginUrl = "https://simplifiapi2.herokuapp.com/login"
        static let envelopesUrl = "https://simplifiapi.herokuapp.com/envelopes"
        static let userEnvelopeUrl = "https://simplifiapi2.herokuapp.com/user_envelopes"
        static let categoriesUrl = "https://simplifiapi2.herokuapp.com/categories"
        static let accountsUrl = "https://simplifiapi2.herokuapp.com/accounts"
        static let usersUrl = "https://simplifiapi2.herokuapp.com/users"
        static let accessTokenUrl = "https://simplifiapi2.herokuapp.com/get_access_token"
        static let signupUrl = "https://simplifiapi2.herokuapp.com/users"
        static let logoutUrl = "https://simplifiapi2.herokuapp.com/logout"
        static let basicEnvelopesUrl = "https://simplifiapi2.herokuapp.com/get_envelopes"
        
        //not currently in use
        static let goalsUrl = "https://simplifiapi.herokuapp.com/goals"
        static let accountTransactionUrl = "https://simplifiapi2.herokuapp.com/account_transactions"
        static let lineItemsUrl = "https://simplifiapi.herokuapp.com/line_items"
    }
    
}
