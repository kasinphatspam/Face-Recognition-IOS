//
//  RecognitionService.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 9/11/2566 BE.
//

import Foundation

struct EncoderResponse: Codable {
    let message: String
}

struct RecognitionResponse: Codable {
    let checkedTime: String
    let accuracy: Float
    let statusCode: Int
    let result: Contact?
}

class RecognitionService: Connection{
    
    // server connection configs
    private var user: Users? = nil
    private var organization: Organization? = nil
    private var serverConfig: ServerConfig? = nil
    
    // response object
    private var encoderResponse: EncoderResponse? = nil
    private var recognitionResponse: RecognitionResponse? = nil
    
    override init() {
        self.serverConfig = ServerConfig()
    }
    
    func config(user: Users, organization: Organization) {
        reset()
        self.user = user
        self.organization = organization
    }
    
    func trains(contactId: Int, image: String) async throws -> EncoderResponse {
        reset()
        
        let organizationId = organization?.id
        let userId = user?.id
        
        if(userId == nil || organizationId == nil) {
            // throw error
        }
        
        let body = [
            "image": image,
        ]
        
        let request = try await posts(
            from: "http://\(serverConfig!.ip)/organization/\(organizationId!)/contact/\(contactId)/encode",
            parameter: body
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(EncoderResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                return
            }
            
            self.encoderResponse = decoded
            
        }
        task.resume()
        
        return self.encoderResponse!
    }
    
    func recognize(image: String) async throws -> RecognitionResponse{
        reset()
        
        let organizationId = organization?.id
        let userId = user?.id
        
        if(userId == nil || organizationId == nil) {
            // throw error
        }
        
        let body = [
            "image": image,
        ]
        
        let request = try await posts(
            from: "http://\(serverConfig!.ip)/organization/\(organizationId!)/contact/encode/recognition",
            parameter: body
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(RecognitionResponse.self, from: data) else {
                print("Error: Couldn't decode data into auth response")
                return
            }
            
            self.recognitionResponse = decoded
        }
        task.resume()
        
        return self.recognitionResponse!
    }
    
    private func reset() {
        // reset previous response
        self.encoderResponse = nil
        self.recognitionResponse = nil
    }
}
