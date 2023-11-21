//
//  LoginViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 10/11/2566 BE.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    var signal: Observable<Signals> = Observable(Signals(command: ""))
    
    func login(email: String, password: String) async throws {
        try await authService.login(email: email, password: password) { error , success, session in
            if error != nil {
                self.signal.value = Signals(command: "AUTH_LOGIN_FAILED")
                return
            }
            
            if success {
                self.signal.value = Signals(command: "AUTH_LOGIN_COMPLETED")
            }
        }
    }
    
    func fetch() async throws {
        try await authService.getCurrentUser { error, success, user in
            if error != nil {
                return
            }
            
            if success {
                if user?.organization == nil {
                    self.signal.value = Signals(command: "CHECK_ORGANIZATION_FAILED")
                    return
                }
                self.signal.value = Signals(command: "CHECK_ORGANIZATION_COMPLETED")
            }
        }
       
    }
}
