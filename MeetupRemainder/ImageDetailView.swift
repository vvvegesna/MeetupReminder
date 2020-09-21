//
//  ImageDetailView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/17/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI

struct ImageDetailView: View {
    var selectedMember: Member
    var body: some View {
        GeometryReader { geo in
            selectedMember.image
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width)
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var member = Member(name: "Vegas", image: UIImage(systemName: "person")!)
    static var previews: some View {
        ImageDetailView(selectedMember: member)
    }
}
