//
//  JoinOrganizationView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct JoinOrganizationView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Ask the leader to receive the joining code.")) {
                TextField("6 digits", text: $username)
            
            }
            
            Button("Continue") {
                
            }
            Button(action: {
                
            }) {
                Text("Log out")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    JoinOrganizationView()
}
