//
//  ContentViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    func fetch() async throws {
        let userService = UserService()
        let user = try await userService.getUserById(id: 1)
        print(user)
    }
    
    func register() async throws {
        let authService = AuthService()
        try await authService.register(email: "kasinphat2@gmail.com", password: "pam40624", firstname: "Mahiru", lastname: "Shiina", personalId: "1509966278553")
    }
    
//    func login() async throws {
//        let authService = AuthService()
//        try await authService.login(email: "kasinphat2@gmail.com", password: "pam40624")
//    }
}
