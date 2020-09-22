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
                    NavigationLink(
                        destination: ImageDetailView(selectedMember: member)) {
                        HStack {
                            member.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text(member.name)
                        }
                    }
                }
                .onAppear(perform: loadData)
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
                    PhotoNameView { name, location in
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
        guard let selectedImage = self.inputImage else { return }
        let member = Member(name: name, image: selectedImage)
        membersList.append(member)
        activeSheet = .none
        saveData()
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedMembers")
        do {
            let data = try Data(contentsOf: fileName)
            membersList = try JSONDecoder().decode([Member].self, from: data)
        } catch {
            print("Unable to load saved data")
        }
    }
    
    func saveData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedMembers")
        
        do {
            let data = try JSONEncoder().encode(self.membersList)
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
