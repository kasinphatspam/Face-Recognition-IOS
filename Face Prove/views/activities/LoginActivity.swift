//
//  LoginView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct LoginActivity: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State private var isLogin: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        
        if self.isLogin {
            JoinOrganizationActivity()
        } else {
            NavigationView {
                Form {
                    Section(header: Text("Introduce your credentials")) {
                        TextField("Email address", text: $email)
                        SecureField("Password", text: $password)
                        
                    }
                    
                    Button("Continue") {
                        Task {
                            try await viewModel.login(email: email, password: password)
                        }
                        
                    }
                    
                    Section(header: Text("other services")) {
                        Button("Forgot your password") {
                            
                        }
                        
                        NavigationLink(destination: RegisterActivity()) {
                            Button("Create a new account") {
                                
                            }
                        }
                        
                    }
                    
                }
                
            }.onAppear() {
                bindViewModel()
            }
        }
        
    }
    
    func bindViewModel() {
        viewModel.signal.bind { signal in
             guard let signal = signal else {
                 return
             }

             if signal.command == "AUTH_LOGIN_COMPLETED" {
                 self.isLogin = true
                 
             } else if signal.command == "AUTH_LOGIN_FAILED" {
                 
             }

         }        
    }
    
}

#Preview {
    LoginActivity()
}
