//
//  LoginViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 10/11/2566 BE.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    
    // view model observable
    var isLoading: Observable<Bool> = Observable(false)
    var signal: Observable<Signals> = Observable(Signals(command: ""))
    
    func login(email: String, password: String) async throws {
        // block multiple action at the same time
        if self.isLoading.value ?? true {
            return
        }
    
        try await authService.login(email: email, password: password) { error , success, userId in
            if error != nil {
                self.signal.value = Signals(command: "AUTH_LOGIN_FAILED")
                return
            }
            
            if success {
                self.signal.value = Signals(command: "AUTH_LOGIN_COMPLETED")
            }
        }
    
        self.isLoading.value = false
    }
}
