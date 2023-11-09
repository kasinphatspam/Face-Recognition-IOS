//
//  LoginView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear() {
                Task {
                    try await viewModel.login(email: "kasinphat@gmail.com", password: "pam40624")
                    bindViewModel()
                }
            }
    }
    
    func bindViewModel() {
        
        viewModel.isLoading.bind { isLoading in
            guard let isLoading = isLoading else {
                return
            }
            
            if isLoading {
                // do something when loading
            } else {
                // do something when finish
            }
        }
        
        viewModel.signal.bind { signal in
            guard let signal = signal else {
                return
            }
            
            if signal.command == "AUTH_LOGIN_COMPLETED" {
                // change view to main view
                print("Login completed")
            } else if signal.command == "AUTH_LOGIN_FAILED" {
                print("Login failed")
            }
            
        }
    }
    
}

#Preview {
    LoginView()
}
