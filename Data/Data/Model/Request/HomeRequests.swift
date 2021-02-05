//
//  HomeRequests.swift
//  Data
//
//  Created by prog_zidane on 1/13/21.
//

import Foundation

public struct CaptainStatusRequest: Codable{
    public var avaliable: Bool
    public var avaliableShare: Bool
    public var cityToCityRides: Bool
    
    public init(
        avaliable: Bool,
        avaliableShare: Bool,
        cityToCityRides: Bool
    ) {
        self.avaliable = avaliable
        self.avaliableShare = avaliableShare
        self.cityToCityRides = cityToCityRides
    }
    
}
