//
//  ImageDetailView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/17/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI

struct ImageDetailView: View {
    
    enum CurrentView: String, CaseIterable, Identifiable {
        var id: String {
            rawValue
        }
        case image, map
    }
    
    @State private var currentView: CurrentView = .image
    var selectedMember: Member
    
    var body: some View {
        VStack {
            Picker(selection: $currentView, label: Text("Select View")) {
                ForEach(CurrentView.allCases) { view in
                    Text(view.rawValue).tag(view)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
            if currentView == .image {
                selectedMember.image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } else if currentView == .map, let location = selectedMember.location {
                DetailMapView(savedLocation: location)
                    .padding()
                    .frame(maxWidth: .infinity)
            } else {
                Text("Meetup location for \(selectedMember.name) is not saved")
            }
            Spacer()
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var member = Member(name: "Vegas", image: UIImage(systemName: "person")!, instance: nil)
    static var previews: some View {
        ImageDetailView(selectedMember: member)
    }
}
