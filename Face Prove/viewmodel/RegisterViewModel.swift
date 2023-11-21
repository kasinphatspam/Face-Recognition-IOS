//
//  RegisterViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 20/11/2566 BE.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    var signal: Observable<Signals> = Observable(Signals(command: ""))
    
    func register(email: String, password: String, firstname: String, lastname: String, personalId: String) async throws {
        try await authService.register(email: email, password: password, firstname: firstname, lastname: lastname, personalId: personalId) {
            error, success, session in
            if error != nil {
                self.signal.value = Signals(command: "AUTH_REGISTER_FAILED")
                return
            }
            
            if success {
                self.signal.value = Signals(command: "AUTH_REGISTER_COMPLETED")
            }
        }
    }
    
    func fetch() async throws{
        try await authService.getCurrentUser { error, success, user in
            if error != nil {
                return
            }
        }
    }
}
