//
//  AuthResponses.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation


public struct ConfirmModel:Codable
{
    public let success :Bool
}

public struct SimpleItem: Codable {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

