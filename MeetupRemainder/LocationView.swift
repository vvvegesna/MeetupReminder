//
//  LocationView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/19/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI
import MapKit

fileprivate let locationFetcher = LocationFetcher()

struct LocationView: View {
    
    @State var centerCoordinate = CLLocationCoordinate2D()
    @State var currentLocation: CLLocationCoordinate2D?
    @State var hideAddButton = false
    @State var annotation: MKPointAnnotation?
    
    @Binding var isActive: Bool
    @Binding var enteredLocation: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, currentLocation: currentLocation, withAnnotation: annotation)
                .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
                .onAppear(perform: {
                    locationFetcher.start()
                })
            if !hideAddButton {
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
            }
            UserLocationView(self)
            if !hideAddButton {
                AddButton(self)
            }
        }
        .navigationBarItems(trailing: Button("Save") {
            if let location = currentLocation {
                enteredLocation = location
                isActive = false
            } else if annotation != nil {
                enteredLocation = centerCoordinate
                isActive = false
            }
        })
    }
    struct AddButton: View {
        
        var parent: LocationView
        
        init(_ parent: LocationView) {
            self.parent = parent
        }
        
        var body: some View {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let location = MKPointAnnotation()
                        location.coordinate = parent.centerCoordinate
                        parent.annotation = location
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
    }

    struct UserLocationView: View {
        
        var parent: LocationView
        
        init(_ parent: LocationView) {
            self.parent = parent
        }
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        if let location = locationFetcher.lastKnownLocation {
                            print("Your location is \(location)")
                            parent.currentLocation = location
                            withAnimation {
                                parent.hideAddButton = true
                            }
                        } else {
                            print("Your location is unknown")
                        }
                    }) {
                        Image(systemName: "location.circle.fill")
                            .padding()
                            .background(Color.blue.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .rotationEffect(.degrees(45))
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(isActive: .constant(false), enteredLocation: .constant(CLLocationCoordinate2D(latitude: 51.9, longitude: -110.5)))
    }
}
