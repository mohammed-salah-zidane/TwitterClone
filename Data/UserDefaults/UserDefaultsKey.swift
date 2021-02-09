//
//  UserDefaultsKey.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

public enum UserDefaultsKey
{
    public enum User: String
    {
        case multiUsers = "multiUsers"
        case currentUser = "current-user"
        case token = "token"
        case deviceToken = "deviceToken"
        
        public var name: String {
            get { "\(rawValue)" }
        }
    }
    
    public enum App: String
    {
        case twitterConsumerKey = "m6BEHFThB8QP7ionipCTEcaXT"
        case twitterConsumerSecret = "1TtuyM5LuQJsZzuRPpVWnCaxOs9eGUUy5vWjGxc9mgh27NLjlZ"
        
        public var name: String {
            get { "\(rawValue)" }
        }
    }
}
