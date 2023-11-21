//
//  ContentViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    var signal: Observable<Signals> = Observable(Signals(command: ""))
    
    func getCurrentUser() async throws{
        try await authService.getCurrentUser { error, success, user in
            if error != nil {
                // user not found
                self.signal.value = Signals(command: "USER_NOT_FOUND")
                return
            }
            
            if success {
                if user?.organization == nil {
                    // user has not been joined organization
                    self.signal.value = Signals(command: "USER_HAS_NOT_JOINED_ORGANIZATION")
                    return
                }
                self.signal.value = Signals(command: "USER_HAS_JOINED_ORGANIZATION")
            }
        }
    }
}
