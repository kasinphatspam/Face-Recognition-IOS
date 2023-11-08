//
//  UserService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

class UserService: Connection {
    
    private let authService: AuthService
    
    override init() {
        self.authService = AuthService()
    }
    
    func getUserById(id: Int) async throws -> Users {
        let response = try await gets(from: "http://192.168.0.40:3001/user/\(id)")
        let decoded = try JSONDecoder().decode(Users.self, from: response)
        return decoded
    }
    
    func getCurrentOrganization() async throws -> Organization {
        let id = self.authService.getCurrentUser().id
        let response = try await gets(from: "http://192.168.0.40:3001/user/\(id)/organization")
        let decoded = try JSONDecoder().decode(Organization.self, from: response)
        return decoded
    }
    
}
