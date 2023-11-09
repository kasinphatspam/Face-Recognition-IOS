//
//  AuthService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct AuthResponse: Codable {
    let message: String
    let user: Users
}

class AuthService: Connection {
    
    private var user: Users? = nil
    private var serverConfig: ServerConfig? = nil
    
    override init() {
        self.serverConfig = ServerConfig()
    }
    
    func login(email: String, password: String) async throws {
        let body = [
            "email": email,
            "password": password
        ]
        
        let request = try await posts(
            from: "http://\(serverConfig!.ip)/auth/login",
            parameter: body
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                return
            }
            
            self.user = decoded.user
        }
        
        task.resume()
        
    }
    
    func register(email: String, password: String, firstname: String, lastname: String, personalId: String) async throws {
        let body = [
            "email": email,
            "password": password,
            "firstname": firstname,
            "lastname": lastname,
            "personalId": personalId
        ]
        
        let request = try await posts(
            from: "http://\(serverConfig!.ip)/auth/register",
            parameter: body
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                return
            }
            
            self.user = decoded.user
        }
        
        task.resume()
    }
    
    func forgotPassword(email: String) {
        
    }
    
    func getCurrentUser() -> Users? {
        if (self.user == nil) {
            return nil
        }
        return user!
    }
}
