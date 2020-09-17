//
//  ContentView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/12/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var membersList = [Member]()
    @State var image: Image?
    @State var name: String = ""
    @State var inputImage: UIImage?
    @State var activeSheet: ActiveSheet?
    
    enum ActiveSheet: String, Identifiable {
        var id: String {
            rawValue
        }
        case image, name
    }
    
    var body: some View {
        let imageBinding = Binding(
            get: {
                self.inputImage
            }, set: {
                self.inputImage = $0
                self.enterPhotoName()
            })
        return NavigationView {
            VStack {
                List(membersList, id: \.name) { member in
                    HStack {
                        member.icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(member.name)
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        self.activeSheet = .image
                    }) {
                        Image(systemName: "person.badge.plus")
                            .font(.title)
                            .padding(.trailing)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Members")
            .sheet(item: $activeSheet) { currentSheet in
                if currentSheet == .image {
                    ImagePicker(inputImage: imageBinding)
                } else if currentSheet == .name {
                    PhotoNameView { name in
                        self.buildMember(name: name)
                    }
                }
            }
        }
    }
    
    func enterPhotoName() {
        if let uiImage = inputImage {
            image = Image(uiImage: uiImage)
            activeSheet = .name
        }
    }
    
    func buildMember(name: String) {
        guard let selectedImage = self.image else { return }
        let member = Member(name: name, icon: selectedImage)
        membersList.append(member)
        activeSheet = .none
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
