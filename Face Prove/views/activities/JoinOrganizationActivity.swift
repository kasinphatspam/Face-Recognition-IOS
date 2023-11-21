//
//  JoinOrganizationView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct JoinOrganizationActivity: View {
    
    @Binding var isJoinOrg: Bool
    @Binding var isLogin: Bool
    @StateObject var viewModel = JoinOrganizationViewModel()
    
    // alert dialog
    @State private var isPresentingAlert: Bool = false
    @State private var alertText: String = ""
    
    // loading sheet
    @State private var showResults = false
    
    // organization information
    @State private var passcode: String = ""
    
    // keyboard interupt
    @FocusState var isFocus: Bool
    
    var body: some View {
        
        Form {
            Section(header: Text("Ask the leader to receive the joining code.")) {
                TextField("6 digits", text: $passcode)
                    .autocapitalization(.allCharacters)
                    .focused($isFocus)
            }
            
            Button("Continue") {
                isFocus = false
                if !passcode.isEmpty {
                    self.showResults = true
                    Task {
                        try await viewModel.join(passcode: passcode)
                    }
                } else {
                    alertText = "Please fill out passcode field."
                    isPresentingAlert = true
                }
            }
            Button(action: {
                isLogin = false
                viewModel.logout()
            }) {
                Text("Log out")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Join Enterprise")
        .navigationBarTitleDisplayMode(.large)
        .alert(alertText,
                isPresented: $isPresentingAlert) {
        }.sheet(isPresented: $showResults, content: {
            ProgressView().presentationDetents([.medium, .large])
        })
        .onAppear() {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        viewModel.signal.bind { signal in
            showResults = false
             guard let signal = signal else {
                 return
             }

             if signal.command == "JOIN_ORGANIZATION_COMPLETED" {
                 Task {
                     try await viewModel.fetch()
                     isJoinOrg = true
                 }
                 
             } else if signal.command == "JOIN_ORGANIZATION_FAILURE" {
                 self.alertText = "Passcode you entered incorrect."
                 self.isPresentingAlert = true
             }

         }
    }
}

#Preview {
    JoinOrganizationActivity(isJoinOrg: .constant(false), isLogin: .constant(true))
}
