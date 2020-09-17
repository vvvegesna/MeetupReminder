//
//  PhotoNameView.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/12/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI

struct PhotoNameView: View {
    
    @State var enteredName: String = ""
    var nameEntered: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter name of the member", text: $enteredName)
                }
            }
            .navigationBarTitle("Create Member", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                if !self.enteredName.isEmpty {
                    self.nameEntered(self.enteredName)
                } else {
                    //present validation alert
                }
            })
        }
    }
}

struct PhotoNameView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoNameView { name in
            print(name)
        }
    }
}
