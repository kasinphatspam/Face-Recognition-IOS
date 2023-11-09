//
//  LoginViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 10/11/2566 BE.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    
    func login(email: String, password: String) async throws {
        try await authService.login(email: email, password: password)
    }
}
