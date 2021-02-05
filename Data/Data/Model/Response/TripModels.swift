//
//  TripModels.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//

import CoreLocation

public struct PickPoint: Codable
{
    public var lat: Double?
    public var lng: Double?
    public var name: String?
    
    public init(lat: Double? = nil, lng: Double? = nil, name: String? = nil) {
        self.lat = lat
        self.lng = lng
        self.name = name
    }
    
    public func toCoordinate2D() -> CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(
            latitude: CLLocationDegrees(exactly: self.lat ?? 0)!,
            longitude: CLLocationDegrees(exactly: self.lng ?? 0)!
        )
    }
}


public enum RideScope: Int, Codable
{
    case residential = 0
    case cityToCity = 1
}
