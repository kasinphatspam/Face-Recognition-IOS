//
//  LoginView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Introduce your credentials")) {
                    TextField("Email address", text: $username)
                    SecureField("Password", text: $password)
                    
                }
                
                Button("Continue") {
                    
                }
                
                Section(header: Text("other services")) {
                    Button("Forgot your password") {
                        
                    }
                    
                    NavigationLink(destination: RegisterView()) {
                        Button("Create a new account") {
                            
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
}

#Preview {
    LoginView()
}
