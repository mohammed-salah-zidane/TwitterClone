//
//  UserModel.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation
public struct User: Codable
{
    public var id: String?
    public var screenName : String?
    
    public init(id: String? = nil, screenName: String? = nil) {
        self.id = id
        self.screenName = screenName
    }
}

public struct Account: Codable
{
    public var user: User
    public var accessToken: String
    
    public init(user: User, accessToken: String) {
        self.user = user
        self.accessToken = accessToken
    }
}
