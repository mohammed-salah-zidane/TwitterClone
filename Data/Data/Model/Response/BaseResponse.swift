//
//  BaseResponse.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation

public struct BaseResponse<T: Codable>: Codable
{
    public var error: [String]?
    public var done: Bool
    public var statusCode: Int
    public var data: T?
}

public struct SuccessResponse:Codable
{
    public var error: [String]?
    public var done: Bool
    public var statusCode: Int
}
