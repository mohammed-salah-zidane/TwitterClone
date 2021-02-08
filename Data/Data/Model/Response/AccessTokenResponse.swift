//
//  AccessTokenResponse.swift
//  Data
//
//  Created by prog_zidane on 2/8/21.
//

import Foundation

// MARK: - AccessTokenResponse
public struct AccessTokenResponse: Codable {
    public var tokenType, accessToken: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
    }
}
