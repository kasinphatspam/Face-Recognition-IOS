//
//  EditProfileView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct EditProfileActivity: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User inforamtion")) {
                    TextField("First Name", text: $username)
                    TextField("Last Name", text: $password)
                }
                
                Section(header: Text("More information")) {
                    TextField("Personal Id", text: $username)
                    TextField("Date of birth", text: $password)
                    TextField("Gender", text: $password)
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
