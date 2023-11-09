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
    
        try await authService.login(email: email, password: password) { error , success, user in
            if let error = error {
                self.signal.value = Signals(command: "AUTH_LOGIN_FAILED")
                return
            }
            
            if success, let user = user {
                self.signal.value = Signals(command: "AUTH_LOGIN_COMPLETED")
                print(user.firstname)
            }
        }
    
        self.isLoading.value = false
    }
}
