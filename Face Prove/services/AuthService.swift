//
//  AuthService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct AuthResponse: Codable {
    let message: String
    let id: Int
}

enum JSONDecoderError: Error {
    case decodeFailure
}

enum AuthLoginError: Error {
    
}

class AuthService: Connection {
    
    private var userId: Int? = nil
    private var serverConfig: ServerConfig? = nil
    
    override init() {
        self.serverConfig = ServerConfig()
    }
    
    func login(email: String, password: String, completion: @escaping ((Error?, Bool, Int?) -> Void)) async throws {
        let body = [
            "email": email,
            "password": password
        ]
        
        let request = try await posts(
            from: "https://\(serverConfig!.ip)/auth/login",
            parameter: body
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("AuthService: \(error?.localizedDescription ?? "No data")")
                completion(error, false, nil)
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                completion(JSONDecoderError.decodeFailure , false, nil)
                print("AuthService: Error decode failure")
                return
            }
            
            completion(nil, true, decoded.id)
            print("AuthService: login user id: \(decoded.id) successfully")
            
        }
        
        task.resume()
    }
    
    func register(email: String, password: String, firstname: String, lastname: String, personalId: String, completion: @escaping ((Error?, Bool, Int?) -> Void)) async throws {
        let body = [
            "email": email,
            "password": password,
            "firstname": firstname,
            "lastname": lastname,
            "personalId": personalId
        ]
        
        let request = try await posts(
            from: "https://\(serverConfig!.ip)/auth/register",
            parameter: body
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, false , nil)
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                completion(JSONDecoderError.decodeFailure, false , nil)
                return
            }
            
            completion(nil, true, decoded.id)
        }
        
        task.resume()
    }
    
    func forgotPassword(email: String) {
        
    }
    
    func getCurrentUser() async throws -> Int? {
        if (self.userId == nil) {
            return nil
        }
        return self.userId!
    }
    
}
