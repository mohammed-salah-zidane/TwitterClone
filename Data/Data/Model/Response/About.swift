//
//  About.swift
//  Data
//
//  Created by prog_zidane on 1/27/21.
//

import Foundation

// MARK: - DataClass
public struct AboutUsData: Codable {
    public var images: [String]?
    public var title, body: String?
}

// MARK: - ContactUsData
public struct ContactUsData: Codable {
    public var images: [String]?
    public var phone, addressText, lng, lat: String?
    public var workingHours: String?

    enum CodingKeys: String, CodingKey {
        case images, phone
        case addressText = "address_text"
        case lng, lat
        case workingHours = "working_hours"
    }
}

// MARK: - PrivacyData
public struct PrivacyData: Codable {
    public var images: [String]?
    public var captianURL, riderURL: String?

    enum CodingKeys: String, CodingKey {
        case images
        case captianURL = "captian_url"
        case riderURL = "rider_url"
    }
}
