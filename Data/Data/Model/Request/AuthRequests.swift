//
//  AuthRequests.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation


public struct VarifyRequest: Codable {
    let mobile, code: String
    var appType = 1
    
    public init(mobile: String, code: String, appType: Int = 1) {
        self.mobile = mobile
        self.code = code
        self.appType = appType
    }
}


public struct PersonalInfoRequest: Codable {
    var drivingLicense: Data
    var name: String
    var dateOfBirth: String
    var identitiyNumber: String
    var licenceNumber: String
    
    public init(
        drivingLicence: Data,
        name: String,
        dateOfBirth: String,
        identitiyNumber: String,
        licenceNumber: String
    ) {
        self.drivingLicense = drivingLicence
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.identitiyNumber = identitiyNumber
        self.licenceNumber = licenceNumber
    }
}

public struct VehicleInfoRequest: Codable {
    public var carPhoto: Data
    public var carLicense: Data
    public var manufacturingYear: String
    public var plateNumbers: String
    public var plateCharacters: String
    public var colorId: String
    public var modelId: String
    public var brandId: String
    public var totalSeats: String
    
    public init(
        carPhoto: Data,
        carLicense: Data,
        manufacturingYear: String,
        plateNumbers: String,
        plateCharacters: String,
        colorId: String,
        modelId: String,
        brandId: String,
        totalSeats: String
    ) {
        self.carPhoto = carPhoto
        self.carLicense = carLicense
        self.manufacturingYear = manufacturingYear
        self.plateNumbers = plateNumbers
        self.plateCharacters = plateCharacters
        self.colorId = colorId
        self.modelId = modelId
        self.brandId = brandId
        self.totalSeats = totalSeats
    }
}
