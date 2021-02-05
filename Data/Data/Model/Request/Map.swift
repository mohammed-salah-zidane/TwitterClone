//
//  Map.swift
//  Data
//
//  Created by prog_zidane on 12/13/20.
//

import Foundation
import CoreLocation

public enum RouteMode: String
{
    case driving = "driving"
    case walking = "walking"
}

public struct LocationPoint: Codable
{
    var name:String
    var lat:Double
    var long:Double
    var date:Date
}

public struct DirectionsRequest {
    public let source: CLLocationCoordinate2D
    public let destination: CLLocationCoordinate2D
    public let mode: RouteMode
    
    public init(
        source: CLLocationCoordinate2D,
        destination: CLLocationCoordinate2D,
        mode: RouteMode
    ) {
        self.source = source
        self.destination = destination
        self.mode = mode
    }
}
