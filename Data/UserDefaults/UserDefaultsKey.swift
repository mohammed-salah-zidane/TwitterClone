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
        //"AIzaSyBJTwNbw2QXsfdPgWQBoK3Zp4kbORXdtTY" //alada
        //"AIzaSyBMt1gYV4ebnSmvdMTJlPsuKznmuMZ0Mik" //fr
        //"AIzaSyBBKY11a522j9BWW04HvjoOzd64wWqjZ90" // rakeb
        
        case googleMapsAPIKey = "AIzaSyBBKY11a522j9BWW04HvjoOzd64wWqjZ90"

        public var name: String {
            get { "\(rawValue)" }
        }
    }
    
    
}
