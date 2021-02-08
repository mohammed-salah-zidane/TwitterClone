//
//  AuthResponses.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation


public struct AuthResponse:Codable
{
    public var oauthToken, userID, oauthTokenSecret, screenName: String?

    enum CodingKeys: String, CodingKey {
        case oauthToken = "oauth_token"
        case userID = "user_id"
        case oauthTokenSecret = "oauth_token_secret"
        case screenName = "screen_name"
    }
}

public struct SimpleItem: Codable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

