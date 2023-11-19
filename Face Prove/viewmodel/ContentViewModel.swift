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
    
    func getCurrentUser() -> Bool{
        if authService.getCurrentUser() == nil {
            return false
        }
        return true
    }
}
