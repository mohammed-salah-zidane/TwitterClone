//
//  UserModel.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import Foundation

public struct User: Codable
{
    public var id: Int
    public var avatar : String
    public var completedProfile : Bool
    public var mobile : String
    public var name : String?
    public var dateOfBirth : String?
    public var gender : Int
    public var email : String?
}

public struct Captain: Codable {
    public var user: User?
    public var avaliable: Bool?
    public var identitiyNumber, dateOfBirth: String?
    public var totalNumberOfRates: Int?
    public var extraInfo: ExtraInfo?
    public var overRate: Double?
    public var cityToCityRides: Bool?
    public var name, licenceNumber: String?
    public var balance: Double?
    public var activeCarName: String?
    public var id: Int?
    public var completedProfile: Bool?
    public var licenseURL: String?
    public var phone, avatar: String?
    public var avaliableShare: Bool?
    public var totalNumberOfRides, userID: Int?
    public var approveState: AccountState?
    
    enum CodingKeys: String, CodingKey {
        case avaliable, identitiyNumber, dateOfBirth, totalNumberOfRates, extraInfo, overRate, cityToCityRides, name, licenceNumber, balance, activeCarName, id, completedProfile
        case licenseURL = "licenseUrl"
        case phone, avatar, avaliableShare, approveState, totalNumberOfRides
        case userID = "userId"
    }
    
    public init() {
        user = nil
        id = 0
        userID = 0
        name = ""
        phone = ""
        dateOfBirth = ""
        avatar = ""
        identitiyNumber = ""
        licenceNumber = ""
        totalNumberOfRates = 0
        overRate = 0
        balance = 0
        avaliable = false
        avaliableShare = false
        cityToCityRides = false
        licenseURL = ""
        activeCarName = ""
        completedProfile = false
        approveState = .pending
    }
}

// MARK: - ExtraInfo
public struct ExtraInfo: Codable {
    public var carApproveState, captianApproveState, carID: Int?
    public var captianReason: CaptianReason?
    public var carReason: CarReason?

    enum CodingKeys: String, CodingKey {
        case carApproveState, captianApproveState
        case carID = "carId"
        case captianReason, carReason
    }
}

// MARK: - CaptianReason
public struct CaptianReason: Codable {
    public var dateOfBirth, captianLicense, licenceNumber, name: String?
    public var identitiyNumber: String?

    enum CodingKeys: String, CodingKey {
        case dateOfBirth
        case captianLicense = "captian-license"
        case licenceNumber, name, identitiyNumber
    }
}

// MARK: - CarReason
public struct CarReason: Codable {
    public var manufacturingYear, plateNumbers, plateCharacters, modelID: String?
    public var brandID, categoryID, license, photo: String?
    public var colorID, totalSeats: String?

    enum CodingKeys: String, CodingKey {
        case manufacturingYear, plateNumbers, plateCharacters
        case modelID = "modelId"
        case brandID = "brandId"
        case categoryID = "categoryId"
        case license, photo
        case colorID = "colorId"
        case totalSeats
    }
}


public enum AccountState: Int, Codable {
    case pending = 0
    case approved = 1
    case rejected = 2
}

public enum RejectionType {
    case captainOnly
    case carOnly
    case fullRejection
}
