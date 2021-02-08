//
//  FollowersRequest.swift
//  Data
//
//  Created by prog_zidane on 2/8/21.
//

import Foundation

public struct FollowersRequest: Codable {
    public var screen_name: String
    public var cursor: Int = -1
    public var count: Int = 10
    
    public init(screen_name: String, cursor: Int = -1, count: Int) {
        self.screen_name = screen_name
        self.cursor = cursor
        self.count = count
    }
}
