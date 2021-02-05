//
//  Direction.swift
//  Rakeb user
//
//  Created by Essam on 6/12/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation

public class Directions: Codable {
    public let geocodedWaypoints: [GeocodedWaypoint]?
    public let routes: [Route]?
    public let status: String?
    
    public enum CodingKeys: String, CodingKey {
        case geocodedWaypoints = "geocoded_waypoints"
        case routes, status
    }
    
    public init(geocodedWaypoints: [GeocodedWaypoint]?, routes: [Route]?, status: String?) {
        self.geocodedWaypoints = geocodedWaypoints
        self.routes = routes
        self.status = status
    }
}

public class GeocodedWaypoint: Codable {
    public let geocoderStatus, placeID: String?
    public let types: [String]?
    
    public enum CodingKeys: String, CodingKey {
        case geocoderStatus = "geocoder_status"
        case placeID = "place_id"
        case types
    }
    
    public init(geocoderStatus: String?, placeID: String?, types: [String]?) {
        self.geocoderStatus = geocoderStatus
        self.placeID = placeID
        self.types = types
    }
}

public class Route: Codable {
    public let bounds: Bounds?
    public let copyrights: String?
    public let legs: [Leg]?
    public let overviewPolyline: Polyline?
    public let summary: String?
    public let waypointOrder: [Int]?
    
    public enum CodingKeys: String, CodingKey {
        case bounds, copyrights, legs
        case overviewPolyline = "overview_polyline"
        case summary
        case waypointOrder = "waypoint_order"
    }
    
    public init(bounds: Bounds?, copyrights: String?, legs: [Leg]?, overviewPolyline: Polyline?, summary: String?, waypointOrder: [Int]?) {
        self.bounds = bounds
        self.copyrights = copyrights
        self.legs = legs
        self.overviewPolyline = overviewPolyline
        self.summary = summary
        self.waypointOrder = waypointOrder
    }
}

public class Bounds: Codable {
    public let northeast, southwest: Coordinates?
    
    public init(northeast: Coordinates?, southwest: Coordinates?) {
        self.northeast = northeast
        self.southwest = southwest
    }
}

public class Coordinates: Codable {
    public let lat, lng: Double?
    
    public init(lat: Double?, lng: Double?) {
        self.lat = lat
        self.lng = lng
    }
}

public class Leg: Codable {
    public let distance, duration, durationInTrafic: Distance?
    public let endAddress: String?
    public let endLocation: Coordinates?
    let startAddress: String?
    let startLocation: Coordinates?
    let steps: [Step]?
    
    enum CodingKeys: String, CodingKey {
        case distance, duration
        case endAddress = "end_address"
        case endLocation = "end_location"
        case startAddress = "start_address"
        case startLocation = "start_location"
        case durationInTrafic = "duration_in_traffic"
        case steps
    }
    
    init(distance: Distance?, duration: Distance?, durationInTrafic: Distance?,
         endAddress: String?, endLocation: Coordinates?,
         startAddress: String?, startLocation: Coordinates?, steps: [Step]?) {
        self.distance = distance
        self.duration = duration
        self.endAddress = endAddress
        self.endLocation = endLocation
        self.startAddress = startAddress
        self.startLocation = startLocation
        self.durationInTrafic = durationInTrafic
        self.steps = steps
    }
}

public class Distance: Codable {
    public let text: String?
    public let value: Int?
    
    public init(text: String?, value: Int?) {
        self.text = text
        self.value = value
    }
}

public class Step: Codable {
    public let distance, duration: Distance?
    public let endLocation: Coordinates?
    public let travelMode: String?
    public let htmlInstructions: String?
    public let polyline: Polyline?
    public let startLocation: Coordinates?
    
    public enum CodingKeys: String, CodingKey {
        case distance, duration
        case endLocation = "end_location"
        case travelMode = "travel_mode"
        case htmlInstructions = "html_instructions"
        case polyline
        case startLocation = "start_location"
    }
    
    public init(distance: Distance?, duration: Distance?, endLocation: Coordinates?, travelMode: String?,
         htmlInstructions: String?, polyline: Polyline?, startLocation: Coordinates?) {
        self.distance = distance
        self.duration = duration
        self.endLocation = endLocation
        self.htmlInstructions = htmlInstructions
        self.travelMode = travelMode
        self.polyline = polyline
        self.startLocation = startLocation
    }
}

public class Polyline: Codable {
    public let points: String?
    
    public init(points: String?) {
        self.points = points
    }
}
