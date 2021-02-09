//
// Created by Apple on 01/08/2021.
// Copyright (c) 2020 sha. All rights reserved.
//

import Foundation
import RealmSwift
import ModelsMapper

@objcMembers
public class UserEntity: Object {
    public dynamic var id: Int = 0
    dynamic public var profileImageURL: String?
    dynamic public var userDescription: String?
    dynamic public var followersCount: Int?
    dynamic public var idStr, name: String?
    dynamic public var screenName: String?
    dynamic public var friendsCount: Int?
    dynamic public var verified: Bool?
    
    public override static func primaryKey() -> String? { "id" }
    
}

public class UserEntityMapper: Mapper {
    public typealias I = TwitterUser
    public typealias O = UserEntity

    public func map(_ input: TwitterUser) -> UserEntity {
       let out = UserEntity()
        out.id =  Int(input.id ?? 0)
        out.profileImageURL =  input.profileImageURL
        out.userDescription = input.userDescription
        out.followersCount = input.followersCount
        out.idStr = input.idStr
        out.name = input.name
        out.screenName = input.screenName
        out.friendsCount = input.friendsCount
        out.verified = input.verified
        return out
    }
}

public class TwitterUserMapper: Mapper {
    public typealias I = UserEntity
    public typealias O = TwitterUser

    public func map(_ input: UserEntity) -> TwitterUser {
        TwitterUser(
            id: Double(input.id),
            profileImageURL: input.profileImageURL,
            userDescription: input.userDescription,
            followersCount: input.followersCount,
            idStr: input.idStr,
            name: input.name,
            screenName: input.screenName,
            friendsCount: input.friendsCount,
            verified: input.verified
        )
    }
}
