//
//  OrganizationService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import Foundation

struct OrganizationResponse: Codable {
    let message: String
}

class OrganizationService: Connection {
    
    private let global: GlobalVariables = GlobalVariables()
    private let config: ServerConfig = ServerConfig()
    private var organization: Organization? = nil
    
    func getOrganizationById(id: Int) async throws -> Organization{
        let response = try await gets(from: "\(config.protocal)://\(config.ip)/organization/\(id)")
        let decoded = try JSONDecoder().decode(Organization.self, from: response)
        print("UserService: get user id: \(decoded.id)")
        return decoded
    }
    
    func join(passcode: String, completion: @escaping ((Error?, Bool) -> Void)) async throws {
        
        let userId: Int = GlobalVariables.userId
        
        let request = try await posts(
            from: "\(config.protocal)://\(config.ip)/organization/user/\(userId)/join/\(passcode)",
            parameter: nil
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, false)
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(OrganizationResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                completion(JSONDecoderError.decodeFailure, false)
                return
            }
            print(decoded.message)
            completion(nil, true)
        }
        
        task.resume()
    }
    
    func getCurrentOrganization() async throws -> Organization? {
        let id = try await AuthService().getCurrentUser()
        
        if id == nil {
            print("OrganizationService: Please login before get current organization details")
            return nil
        }
        let response = try await gets(from: "\(config.protocal)://\(config.ip)/user/\(id!)/organization")
        let decoded = try JSONDecoder().decode(Organization.self, from: response)
        return decoded
    }
}
