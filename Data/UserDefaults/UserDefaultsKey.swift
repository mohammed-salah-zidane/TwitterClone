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
        case twitterConsumerKey = "X0IeQidcXoVCB4wNAClGj7WH3"
        case twitterConsumerSecret = "ycyTHe5EowxAbyIlSSMkU0zlAleAB4HsAKKKz3S8lRJtMTMcJC"
        
        public var name: String {
            get { "\(rawValue)" }
        }
    }
}
