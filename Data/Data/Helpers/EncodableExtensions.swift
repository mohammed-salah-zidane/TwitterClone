//
//  EncodableExtensions.swift
//  Rakeb user
//
//  Created by Hmaserv on 7/13/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation

public extension Encodable
{
    func toJSONData() -> Data
    {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
    
    func toJSONString() -> String
    {
        let string = String(data: self.toJSONData(), encoding: String.Encoding.utf8) ?? ""
        return string
    }
    
    func toJSONObject() -> [String: Any]
    {
        let jsonObject = try? JSONSerialization.jsonObject(with: self.toJSONData(), options: []) as? [String: Any]
        return jsonObject ?? [:]
    }
}

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
