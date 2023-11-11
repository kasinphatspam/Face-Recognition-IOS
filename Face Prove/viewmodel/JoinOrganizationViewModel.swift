//
//  JoinOrganizationViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import Foundation

class JoinOrganizationViewModel: ObservableObject {
    
    private let organizationService: OrganizationService = OrganizationService()
    var signal: Observable<Signals> = Observable(Signals(command: ""))

    func join(passcode: String) async throws {
        
        try await organizationService.join(passcode: passcode, completion: { error, status in
            
            if error != nil {
                self.signal.value = Signals(command: "ORGANIZATION_JOIN_FAILURE")
            }
            
            if status {
                self.signal.value = Signals(command: "ORGANIZATION_JOIN_COMPLETED")
            }
        })
    }
    
    
}
