//
//  UserService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct UpdateUsersResponse: Codable {
    let message: String
}

class UserService: Connection {
    
    private var serverConfig: ServerConfig = ServerConfig()
    private var updateUserResponse: UpdateUsersResponse? = nil
    
    func getUserById(id: Int) async throws -> Users {
        let response = try await gets(from: "https://\(serverConfig.ip)/user/\(id)")
        let decoded = try JSONDecoder().decode(Users.self, from: response)
        print("UserService: get user id: \(decoded.id)")
        return decoded
    }
    
    func getOrganizationByUserId(id: Int) async throws -> Organization {
        let response = try await gets(from: "https://\(serverConfig.ip)/user/\(id)/organization")
        let decoded = try JSONDecoder().decode(Organization.self, from: response)
        return decoded
    }
    
    func updateUserImage(id: Int, image: String) async throws -> UpdateUsersResponse {
        let body = [
            "image": image,
        ]
        
        let request = try await puts(from: "https://\(serverConfig.ip)/user/\(id)/image",parameter: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(UpdateUsersResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                return
            }
            
            self.updateUserResponse = decoded
            
        }
        task.resume()
        
        return self.updateUserResponse!
    }
    
    func updateUserDetails(id: Int, image: String, firstname: String?, lastname: String?, gender: String?, personalId: String?, dob: Date?)
    async throws -> UpdateUsersResponse {
        
        var body =  [String: Any]()
        
        if (firstname == nil && lastname == nil && gender == nil && personalId == nil && dob == nil) {
            return UpdateUsersResponse(message: "The update request must contain new values for at least one variable.")
        }
        
        if (firstname != nil) {
            body.updateValue(firstname!, forKey: "firstname")
        }
        
        if (lastname != nil) {
            body.updateValue(lastname!, forKey: "lastname")
        }
        
        if (gender != nil) {
            body.updateValue(gender!, forKey: "gender")
        }
        
        if (personalId != nil) {
            body.updateValue(personalId!, forKey: "personalId")
        }
        
        if (dob != nil) {
            body.updateValue(dob!, forKey: "dob")
        }
        
        let request = try await puts(from: "https://\(serverConfig.ip)/user/\(id)/",parameter: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(UpdateUsersResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                return
            }
            self.updateUserResponse = decoded
        }
        task.resume()
        
        return self.updateUserResponse!
    }
    
}
