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
        case userLocation = "userLocation"
        case currentUser = "current-user"
        case captain = "captain"
        case car = "captain-car"
        case token = "token"
        case deviceToken = "deviceToken"
        
        public var name: String {
            get { "\(rawValue)" }
        }
    }
    
    public enum App: String
    {
        case twitterConsumerKey = "KTgosDXOAelnEnjcMVzSodc5M"
        case twitterConsumerSecret = "Jme22OsZlk9IR7ORzOzWBjRgHVVwXDChMpzjRaI2vQDNiYGcnC"
        
        public var name: String {
            get { "\(rawValue)" }
        }
    }
}
