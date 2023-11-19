//
//  JoinOrganizationView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct JoinOrganizationActivity: View {
    
    @StateObject var viewModel = JoinOrganizationViewModel()
    @State private var passcode: String = ""
    @State private var isDone: Bool = false
    
    var body: some View {
        
        if isDone {
            MainActivity()
        } else {
            Form {
                Section(header: Text("Ask the leader to receive the joining code.")) {
                    TextField("6 digits", text: $passcode)
                    
                }
                
                Button("Continue") {
                    Task {
                        try await viewModel.join(passcode: passcode)
                    }
                }
                Button(action: {
                    
                }) {
                    Text("Log out")
                        .foregroundColor(.red)
                }
            }.onAppear() {
                bindViewModel()
            }
            .navigationTitle("Join Enterprise")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func bindViewModel() {
        viewModel.signal.bind { signal in
             guard let signal = signal else {
                 return
             }

             if signal.command == "ORGANIZATION_JOIN_COMPLETED" {
                 self.isDone = true
                 
             } else if signal.command == "ORGANIZATION_JOIN_FAILURE" {
                 self.isDone = false
             }

         }
    }
}

#Preview {
    JoinOrganizationActivity()
}
