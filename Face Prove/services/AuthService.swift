//
//  AuthService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct AuthResponse: Codable {
    let message: String
    let session: String
}

enum JSONDecoderError: Error {
    case decodeFailure
}

class AuthService: Connection {
    
    private var session: String? = nil
    private var user: User? = nil
    
    /*
     * Fetch current user: this function used for refresh or load user data.
     * After call this, you can get the current user with getCurrentUser method.
     */
    func getCurrentUser(completion: @escaping ((Error?, Bool, User?) -> Void)) async throws {
        // get session from keychain
        let session = self.read()
        if session == nil {
            print("AuthService: System cannot fetch current user because session id is expired")
            completion(nil, false, nil)
            return
        }
        self.session = session
        // set session on global variable for easily to use
        GlobalVariables.session = session!
        
        // call request user details
        try await  gets(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/auth/me",
            header: ["session": session!]
        ) {
            error, status, data in
            guard let data = data, error == nil else {
                completion(nil, false, nil)
                return
            }
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode(User.self, from: data) else {
                print("AuthService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                completion(JSONDecoderError.decodeFailure, false, nil)
                return
            }
            print("AuthService: Fetch user id: \(decoded.id)")
            self.user = decoded
            GlobalVariables.user = decoded
            completion(nil, true, decoded)
        }
    }
    
    /*
     * Sub method for getting current user as Swift Object
     * Important! use fetchCurrentUser() first before calling this function
     */
//    func getCurrentUser() -> User?{
//        if user == nil {
//            return nil
//        }
//        return self.user!
//    }
    
    /*
     * Login
     * get information which user typing and if response code is 200, 
     * system will save the session by writting keychain
     */
    func login(email: String, password: String, 
               completion: @escaping ((Error?, Bool, String?) -> Void)) async throws {
        // prepare payload
        let body = [
            "email": email,
            "password": password
        ]
        
        try await posts(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/auth/login",
            parameter: body,
            header: nil
        ) {
            error, status, data in
            guard let data = data, error == nil else {
                return
            }
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                completion(JSONDecoderError.decodeFailure , false, nil)
                print("AuthService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                return
            }
            // save the session
            self.session = decoded.session
            self.write(token: decoded.session)
            // set session on global variable for easily to use
            GlobalVariables.session = decoded.session
            completion(nil , true, decoded.session)
            print("AuthService: Login successfully by session id: \(self.session!.prefix(6))######...")
        }
    }
    
    /*
     * Logout
     * clear session on device (keychain) and reset global variable
     */
    func logout() {
        self.delete()
        self.session = nil
        self.user = nil
        GlobalVariables.session = ""
    }
    
    /*
     * Register
     * get information which user typing and if response code is 200,
     * system will save the session by writting keychain
     */
    func register(email: String, password: String, firstname: String, lastname: String, personalId: String, 
                  completion: @escaping ((Error?, Bool, String?) -> Void)) async throws {
        // prepare payload
        let body = [
            "email": email,
            "password": password,
            "firstname": firstname,
            "lastname": lastname,
            "personalId": personalId
        ]
        
        try await posts(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/auth/register",
            parameter: body,
            header: nil
        ) {
            error, status, data in
            guard let data = data, error == nil else {
                return
            }
            // convert response body (json) to swift object
            guard let decoded = try? JSONDecoder().decode(AuthResponse.self, from: data) else {
                completion(JSONDecoderError.decodeFailure , false, nil)
                print("AuthService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                return
            }
            
            // save the session
            self.session = decoded.session
            self.write(token: decoded.session)
            // set session on global variable for easily to use
            GlobalVariables.session = decoded.session
            completion(nil , true, decoded.session)
            print("AuthService: Register successfully by session id: \(self.session!.prefix(6))######...")
        }
    }
    
    func forgotPassword(email: String) {
        
    }
    
    /*
     * Keychain - mechanism to store small bits of user data in an encrypted database
     * By in this features, this code use to store the auth session id for remember the user
     *
     * - write:  (save the session)
     * - read:   (read the seesion)
     * - delete: (remove the session)
     */
    
    // store the session (jwt) into keychain
    private func write(token: String) {
        let data = token.data(using: .utf8)
        let service = EnviromentVariable.service
        let account = EnviromentVariable.account
        
        if KeychainHelper.storeDate(data: data!, forService: service, account: account) {
            print("AuthService: Data stored in keychain successfully")
        } else {
            print("AuthService: Failed to store data in keychain")
            if KeychainHelper.updateData(data: data!, forService: service, account: account) {
                print("AuthService: Update data in keychain")
            }else{
                print("AuthService: Failed to update data in keychain")
            }
        }
    }
    
    // retrive the session (jwt) from the keychain
    private func read() -> String? {
        let service = EnviromentVariable.service
        let account = EnviromentVariable.account
        var session: String? = nil
        
        if let retrivedData = KeychainHelper.retrivedData(forService: service, account: account) {
            session = String(decoding: retrivedData, as: UTF8.self)
        } else {
            session = nil
            print("AuthService: Failed to retrive data from keychain")
        }
        return session
    }
    
    // remove the session (jwt) in the keychain
    private func delete() {
        let service = EnviromentVariable.service
        let account = EnviromentVariable.account
        
        if KeychainHelper.deleteData(forService: service, account: account) {
            print("AuthService: Session is cleard")
        } else {
            print("AuthService: Failed to delete data from keychain")
        }
    }
    
}
