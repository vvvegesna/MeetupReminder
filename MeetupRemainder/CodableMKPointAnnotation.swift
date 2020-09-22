//
//  CodableMKPointAnnotation.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/21/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import Foundation
import MapKit

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    enum CodingKeys: CodingKey {
        case latitude, longitude
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(coordinate.latitude, forKey: .latitude)
    }
}

