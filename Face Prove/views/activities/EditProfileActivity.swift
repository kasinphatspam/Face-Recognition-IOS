//
//  EditProfileView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct EditProfileActivity: View {
    
    // user information
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var personalId: String = ""
    
    // more information
    @State private var selectGender: Gender = .Male
    @State private var dob = Date.now
    private var closedRange = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User inforamtion")) {
                    TextField("First Name", text: $firstname)
                    TextField("Last Name", text: $lastname)
                    TextField("Personal Id", text: $personalId)
                }
                
                
                Section(header: Text("More information")) {
                    DatePicker("Date of birth", 
                               selection: $dob ,
                               in: closedRange...Date(), 
                               displayedComponents: .date
                    )
                    Picker("Gender", selection: $selectGender) {
                        Text("Male")
                           .tag(Gender.Male)

                        Text("Female")
                            .tag(Gender.Female)

                        Text("Other")
                            .tag(Gender.Other)
                    }
                    .pickerStyle(.menu)
                }
                
                Button("Save all changes") {
                    
                }
                
                Button(action: {
                    
                }) {
                    Text("Discard")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
}

#Preview {
    EditProfileActivity()
}
