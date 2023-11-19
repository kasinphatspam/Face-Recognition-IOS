//
//  ContentViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    
    func fetch() async throws {
        try await authService.fetchCurrentUser()
    }
    
    func getCurrentUser() -> Int{
        // user not found
        guard let user = authService.getCurrentUser() else {
            return -1
        }
        
        // user has not been joined organization
        guard let organization = user.organization else {
            return 0
        }
        return 1
    }
}
