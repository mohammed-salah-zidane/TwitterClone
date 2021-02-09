//
//  FollowersResponse.swift
//  Data
//
//  Created by prog_zidane on 2/8/21.
//

import Foundation

// MARK: - Welcome
public struct FollowersResponse: Codable {
    public var users: [TwitterUser]?
    public var nextCursor: Int?
    
    enum CodingKeys: String, CodingKey {
        case users
        case nextCursor = "next_cursor"
    }
}

// MARK: - User
public struct TwitterUser: Codable {
    public var profileImageURL: String?
    public var id: Double?
    public var userDescription: String?
    public var followersCount: Int?
    public var idStr, name: String?
    public var screenName: String?
    public var friendsCount: Int?
    public var verified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
        case id
        case userDescription = "description"
        case followersCount = "followers_count"
        case name
        case screenName = "screen_name"
        case friendsCount = "friends_count"
        case verified
    }
    
    public init(
        id: Double? = nil,
        profileImageURL: String? = nil,
        userDescription: String? = nil,
        followersCount: Int? = nil,
        idStr: String? = nil,
        name: String? = nil,
        screenName: String? = nil,
        friendsCount: Int? = nil,
        verified: Bool? = nil
    ) {
        self.id = id
        self.profileImageURL = profileImageURL
        self.userDescription = userDescription
        self.followersCount = followersCount
        self.idStr = idStr
        self.name = name
        self.screenName = screenName
        self.friendsCount = friendsCount
        self.verified = verified
    }
}
