//
//  LocationFetcher.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/18/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
