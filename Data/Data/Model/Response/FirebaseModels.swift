//
//  FirebaseModels.swift
//  Data
//
//  Created by prog_zidane on 1/14/21.
//

import Foundation

public struct FirebaseRide: Codable {
    public var riderId: Int!
    public var status: RideStatus!
    public var rideScope: RideScope!
    public var captainId: Int?
    public var currentLocation: PickPoint?
    public var previousLocation: PickPoint?
}

public enum RideStatus: Int, Codable {
    case new  // just created
    case queued // queued for captian searching
    case accepted // captian found and accept ride
    case started // STATRED
    case running // RUNNING
    case completed //COMPLETED
    case rated //RATED BY RIDER
    case canceled //CANCELLED BY RIDER
    case failedToFindCaptain //NOT GIVE OFFER
}

public struct MessageItem: Codable {
    public var senderId: Int
    public var content: String
    public var timestamp: String
    public var senderType: UserType
}

public enum UserType: Int, Codable {
    case rider
    case captain
}

public struct FirebaseCaptian: Codable {
    public var approval: FirebaseApproval?
    public var current_ride: FirebaseCurrentRide?
    public var offer: FirebaseOfferData?

    enum CodingKeys: String, CodingKey {
        case approval
        case offer
        case current_ride = "current-ride"
    }
}

public struct FirebaseApproval: Codable {
    public var captian_status: AccountState
    public var car_status: AccountState
    
    enum CodingKeys: String, CodingKey {
        case captian_status = "captian-status"
        case car_status = "car-status"
    }
}

public struct FirebaseCurrentRide: Codable {
    public var rideId: Int
}

public struct FirebaseOfferData: Codable {
    public var offerCount: Int
    public var rideId: Int
}
