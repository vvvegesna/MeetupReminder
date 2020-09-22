//
//  DetailMapView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/22/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import MapKit
import SwiftUI

struct DetailMapView: UIViewRepresentable {
    
    var savedLocation: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = savedLocation
        uiView.addAnnotation(annotation)
//        let region = MKCoordinateRegion(center: savedLocation, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
//        uiView.setRegion(region, animated: true)
        uiView.setCenter(savedLocation, animated: true)
    }
}
