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
    
    private var organization: Organization? = nil
    
    func getOrganizationById(id: Int, 
                             completion: @escaping ((Error?, Bool, Organization?) -> Void)) async throws {
        
        try await gets(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/organization/\(id)",
            header: ["session": GlobalVariables.session]
        ) {
            error, status, data in
            guard let data = data, error == nil else {
                completion(error, false, nil)
                return
            }
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode(Organization.self, from: data) else {
                print("OrganizationService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                completion(JSONDecoderError.decodeFailure, false, nil)
                return
            }
            print("OrganizationService: Fetch organization id: \(decoded.id)")
            completion(nil, true, decoded)
        }
    }
    
    func join(passcode: String, 
              completion: @escaping ((Error?, Bool) -> Void)) async throws {
        
        try await posts(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/organization/join/\(passcode)",
            parameter: nil,
            header: ["session": GlobalVariables.session]
        ) {
            error, status, data in
            guard let data = data, error == nil else {
                completion(error, false)
                return
            }
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode(OrganizationResponse.self, from: data) else {
                print("OrganizationService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                completion(JSONDecoderError.decodeFailure, false)
                return
            }
            print("OrganizationService: \(decoded.message)")
            completion(nil, true)
        }
    }
    
    func getAllEmployee(id: Int, completion: @escaping ((Error?, Bool, [User]?) -> Void))
    async throws{
        try await gets(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/organization/\(id)/employee/all",
            header: ["session": GlobalVariables.session]
        ) {
            error, success ,data in
            guard let data = data, error == nil else {
                completion(error, false, nil)
                return
            }
            
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode([User].self, from: data) else {
                print("OrganizationService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                completion(JSONDecoderError.decodeFailure, false, nil)
                return
            }
            print("OrganizationService: Retrieve all employee in organization id: \(id)")
            completion(nil, true, decoded)
            
        }
    }
    
    func getAllContact(id: Int, completion: @escaping ((Error?, Bool, [Contact]?) -> Void))
    async throws {
        try await gets(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/organization/\(id)/contact/all",
            header: ["session": GlobalVariables.session]
        ) {
            error, status, data in
            guard let data = data, error == nil else {
                completion(error, false, nil)
                return
            }
          
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode([Contact].self, from: data) else {
                print("OrganizationService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                completion(JSONDecoderError.decodeFailure, false, nil)
                return
            }
            print("OrganizationService: Retrieve all contact in organization id: \(id)")
            completion(nil, true, decoded)
        }
    }
}
