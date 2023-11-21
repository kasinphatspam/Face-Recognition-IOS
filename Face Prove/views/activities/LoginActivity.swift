//
//  LoginView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

struct LoginActivity: View {
    
    @Binding var isLogin: Bool
    @Binding var isJoinOrg: Bool
    @StateObject var viewModel = LoginViewModel()
    
    // alert dialog
    @State private var isPresentingAlert: Bool = false
    @State private var alertText: String = ""
    
    // loading sheet
    @State private var showResults = false
    
    // security information
    @State private var email: String = ""
    @State private var password: String = ""

    // keyboard interupt
    @FocusState var isFocus: Bool
    
    var body: some View {
            
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            Form {
                Section(header: Text("Introduce your credentials")) {
                    TextField("Email address", text: $email).autocapitalization(.none).focused($isFocus)
                    SecureField("Password", text: $password).autocapitalization(.none).focused($isFocus)
                }
                
                Button("Continue") {
                    isFocus = false
                    if !email.isEmpty && !password.isEmpty{
                        self.showResults = true
                        Task {
                            try await viewModel.login(email: email, password: password)
                        }
                    } else {
                        alertText = "Please fill out email and password field."
                        isPresentingAlert = true
                    }
                }
                
                Section(header: Text("other services")) {
                    Button("Forgot your password") {
                        
                    }
                    
                    NavigationLink(destination: RegisterActivity(isLogin: $isLogin)) {
                        Button("Create a new account") {
                            
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack(alignment: .leading) {
                    Text("Face Prove").font(.subheadline)
                }
            }
        }
        .navigationTitle("Welcome Back!")
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

             if signal.command == "AUTH_LOGIN_COMPLETED" {
                 Task {
                     try await viewModel.fetch()
                 }
                 
             } else if signal.command == "AUTH_LOGIN_FAILED" {
                 self.alertText = "Username or password you entered incorrect."
                 self.isPresentingAlert = true
                 
             } else if signal.command == "CHECK_ORGANIZATION_FAILED" {
                 isJoinOrg = false
                 isLogin = true
             } else if signal.command == "CHECK_ORGANIZATION_COMPLETED" {
                 isJoinOrg = true
                 isLogin = true
             }

         }        
    }
    
}

#Preview {
    LoginActivity(isLogin: .constant(false), isJoinOrg: .constant(false))
}
