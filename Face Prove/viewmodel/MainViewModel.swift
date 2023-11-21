//
//  OrganizationViewModel.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 20/11/2566 BE.
//

import Foundation

class OrganizationPasscodeViewModel: ObservableObject {
    
    func fetch() -> Organization? {
        return GlobalVariables.user?.organization
    }
}

class HeaderInformationViewModel: ObservableObject {
    
    func fetch() -> User? {
        return GlobalVariables.user
    }
}

class InformationViewModel: ObservableObject {
    
    private let authService: AuthService = AuthService()
    func logout() {
        authService.logout()
    }
}

class EmployeeListViewModel: ObservableObject {
    
    private let organizationService: OrganizationService = OrganizationService()
    var users: Observable<[User]> = Observable(nil)
    
    func fetch() async throws{
        if GlobalVariables.user != nil && GlobalVariables.user?.organization != nil {
            try await organizationService.getAllEmployee(
                id: GlobalVariables.user!.organization!.id)
            {
                error, success, data in
                
                self.users.value = data
            }
        }
    }
    
}


class CustomerListViewModel: ObservableObject {
    
    private let organizationService: OrganizationService = OrganizationService()
    var contacts: Observable<[Contact]> = Observable(nil)
    
    func fetch() async throws {
        if GlobalVariables.user != nil && GlobalVariables.user?.organization != nil {
            try await organizationService.getAllContact(
                id: GlobalVariables.user!.organization!.id) 
            {
                error, success, data in
                
                self.contacts.value = data
            }
        }
    }
}
