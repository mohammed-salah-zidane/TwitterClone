//
//  Car.swift
//  Data
//
//  Created by prog_zidane on 1/21/21.
//

import Foundation

public struct Car: Codable {
    public var cityToCityRides: Bool?
    public var totalSeats, avaliableSeats, id: Int?
    public var manufacturingYear: String?
    public var isDefault: Bool?
    public var status, plateNumbers: Int?
    public var approveState: AccountState?
    public var plateCharacters: String?
    public var captianID: Int?
    public var categoryID: Int?
    public var colorID: Int?
    public var extraInfo: CarExtraInfo?
    public var category: String?
    public var color: SimpleItem?
    public var model: CarModel?
    public var name: String?
    public var licenseURL: String?
    public var photoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case cityToCityRides, totalSeats, avaliableSeats, id, manufacturingYear, isDefault, approveState, status, plateNumbers, plateCharacters
        case captianID = "captianId"
        case categoryID = "categoryId"
        case colorID = "colorId"
        case extraInfo, category, color, model, name
        case licenseURL = "licenseUrl"
        case photoURL = "photoUrl"
    }
    
    public init(cityToCityRides: Bool? = nil, totalSeats: Int? = nil, avaliableSeats: Int? = nil, id: Int? = nil, manufacturingYear: String? = nil, isDefault: Bool? = nil, approveState: AccountState? = nil, status: Int? = nil, plateNumbers: Int? = nil, plateCharacters: String? = nil, captianID: Int? = nil, categoryID: Int? = nil, colorID: Int? = nil, extraInfo: CarExtraInfo? = nil, category: String? = nil, color: SimpleItem? = nil, model: CarModel? = nil, name: String? = nil, licenseURL: String? = nil, photoURL: String? = nil) {
        self.cityToCityRides = cityToCityRides
        self.totalSeats = totalSeats
        self.avaliableSeats = avaliableSeats
        self.id = id
        self.manufacturingYear = manufacturingYear
        self.isDefault = isDefault
        self.approveState = approveState
        self.status = status
        self.plateNumbers = plateNumbers
        self.plateCharacters = plateCharacters
        self.captianID = captianID
        self.categoryID = categoryID
        self.colorID = colorID
        self.extraInfo = extraInfo
        self.category = category
        self.color = color
        self.model = model
        self.name = name
        self.licenseURL = licenseURL
        self.photoURL = photoURL
    }
}

// MARK: - CarExtraInfo
public struct CarExtraInfo: Codable {
    public var manufacturingYear, plateNumbers, plateCharacters, categoryID: String?
    public var colorID, modelID, brandID, totalSeats: String?
    public var license, photo: String?

    enum CodingKeys: String, CodingKey {
        case manufacturingYear, plateNumbers, plateCharacters
        case categoryID = "categoryId"
        case colorID = "colorId"
        case modelID = "modelId"
        case brandID = "brandId"
        case totalSeats, license, photo
    }
}

// MARK: - Model
public struct CarModel: Codable {
    public var id: Int?
    public var name: String?
    public var brand: SimpleItem?
}


// MARK: - Welcome
public struct ColorItem: Codable {
    public var id: Int?
    public var name: Name?
    public var hexCode: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case hexCode = "hex_code"
    }
}

// MARK: - Name
public struct Name: Codable {
    public var en, ar: String?
}
