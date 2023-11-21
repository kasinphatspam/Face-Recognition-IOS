//
//  RegisterView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

enum Gender {
    case Male;
    case Female;
    case Other;
}

struct RegisterActivity: View {
    
    @Binding var isLogin: Bool
    @StateObject var viewModel = RegisterViewModel()
    
    // alert dialog
    @State private var isPresentingAlert: Bool = false
    @State private var alertText: String = ""
    // loading sheet
    @State private var showResults = false
    
    // user information
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var personalId: String = ""
    
    // security information
    @State private var email: String = ""
    @State private var password: String = ""
    
    // keyboard interupt
    @FocusState var isFocus: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        Form {
            Section(header: Text("User inforamtion")) {
                TextField("First Name", text: $firstname)
                    .autocapitalization(.none)
                    .focused($isFocus)
                TextField("Last Name", text: $lastname)
                    .autocapitalization(.none)
                    .focused($isFocus)
                TextField("Personal Id", text: $personalId)
                    .keyboardType(.numberPad)
                    .autocapitalization(.none)
                    .focused($isFocus)
            }
            
            Section(header: Text("Security")) {
                TextField("Email address", text: $email)
                    .autocapitalization(.none)
                    .focused($isFocus)
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .focused($isFocus)
            }
            
            Button("Continue") {
                isFocus = false
                if !email.isEmpty 
                    && !password.isEmpty
                    && !firstname.isEmpty
                    && !lastname.isEmpty
                    && !personalId.isEmpty
                {
                    self.showResults = true
                    Task {
                        try await viewModel.register(
                            email: email,
                            password: password,
                            firstname: firstname,
                            lastname: lastname,
                            personalId: personalId
                        )
                    }
                } else {
                    alertText = "Please fill out input field."
                    isPresentingAlert = true
                }
            }
            
            Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                Text("Discard")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Create new account")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertText, isPresented: $isPresentingAlert) {}
        .sheet(isPresented: $showResults, content: {
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

             if signal.command == "AUTH_REGISTER_COMPLETED" {
                 Task {
                     try await viewModel.fetch()
                 }
                 isLogin = true
                 
             } else if signal.command == "AUTH_REGISTER_FAILED" {
                 self.alertText = "Somthing wrong, please try again later."
                 self.isPresentingAlert = true
             }
         }
    }
}

#Preview {
    RegisterActivity(isLogin: .constant(false))
}
