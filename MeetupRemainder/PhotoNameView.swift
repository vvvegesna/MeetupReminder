//
//  PhotoNameView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/12/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI
import MapKit

struct PhotoNameView: View {
    
    @State var enteredName: String = ""
    @State var entredLocation: CLLocationCoordinate2D?
    var nameEntered: (String, CLLocationCoordinate2D?) -> Void
    @State var isNavLinkActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter name of the member", text: $enteredName)
                    .padding()
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .padding()
                NavigationLink(destination: LocationView(isActive: $isNavLinkActive, enteredLocation: $entredLocation), isActive: $isNavLinkActive) {
                    Text("Add Location")
                }
                .isDetailLink(false)
                if entredLocation != nil {
                    Text("Location Saved")
                        .foregroundColor(.green)
                }
                Spacer()
            }
            .navigationBarTitle("Create Member", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                if !self.enteredName.isEmpty {
                    self.nameEntered(self.enteredName, self.entredLocation)
                } else {
                    //present validation alert
                }
            })
        }
    }
}

struct PhotoNameView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoNameView { name, location in
            print(name)
        }
    }
}
