//
//  HomeResponses.swift
//  Data
//
//  Created by prog_zidane on 1/13/21.
//

import Foundation

// MARK: - Welcome
public struct UpdateLocationResponse: Codable {
    public var id: Int?
    public var name: String?
    public var cityToCityRides: Bool?
    public var location: LocationWithoutName?
    public var status: Bool?
    public var manufacturingYear, plateNumbers: Int?
    public var plateCharacters: String?
    public var totalSeats: Int?
}

// MARK: - Location
public struct LocationWithoutName : Codable {
    public var lat, lng: Int?
}

public struct UserAvatarResponse: Codable {
    public let avatar: String
}
