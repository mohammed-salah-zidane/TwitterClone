//
//  SupportRequest.swift
//  Data
//
//  Created by prog_zidane on 1/26/21.
//

import Foundation

public struct SupportTicketRequest: Codable {
    public var userId, source: Int
    public var name, phone, details: String
    
    public init(
        userId: Int,
        source: Int,
        name: String,
        phone: String,
        details: String
    ) {
        self.userId = userId
        self.source = source
        self.name = name
        self.phone = phone
        self.details = details
    }
}
