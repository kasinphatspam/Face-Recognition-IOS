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
    let accuracy: [Float]?
    let statusCode: Int
    let result: [Contact]?
}

class RecognitionService: Connection{
    
    // response object
    private var encoderResponse: EncoderResponse? = nil
    private var recognitionResponse: RecognitionResponse? = nil
    
    func trains(contactId: Int, image: String, completion: @escaping ((Error?, Bool, EncoderResponse?) -> Void)) 
    async throws {
        
        if GlobalVariables.user == nil {
            return
        }
        
        if GlobalVariables.user?.organization == nil {
            return
        }
        
        let body = [
            "image": image,
        ]
        
        try await puts(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/organization/\(GlobalVariables.user!.organization!)/contact/\(contactId)/encode",
            parameter: body,
            header: ["session": GlobalVariables.session]) {
                error, success, data in
                guard let data = data, error == nil else {
                    completion(error, false, nil)
                    return
                }
                
                guard let decoded = try? JSONDecoder().decode(EncoderResponse.self, from: data) else {
                    print("RecognitionService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                    completion(JSONDecoderError.decodeFailure, false, nil)
                    return
                }
                print("RecognitionService: Encode new faces of contact id: \(contactId)")
                completion(nil, true, decoded)
            }
    }
    func recognize(image: String, completion: @escaping ((Error?, Bool, RecognitionResponse?) -> Void))
    async throws {
        
        if GlobalVariables.user == nil {
            return
        }
        
        if GlobalVariables.user?.organization == nil {
            return
        }
        
        let body = [
            "image": image,
        ]
        try await posts(
            from: "\(EnviromentVariable.protocal)://\(EnviromentVariable.ip)/organization/\(GlobalVariables.user!.organization!.id)/contact/encode/recognition",
            parameter: body,
            header: ["session": GlobalVariables.session]) {
                error, success, data in
                guard let data = data, error == nil else {
                    completion(error, false, nil)
                    return
                }
                
                guard let decoded = try? JSONDecoder().decode(RecognitionResponse.self, from: data) else {
                    print("RecognitionService: Error decode failure \(String(decoding: data, as: UTF8.self))")
                    completion(JSONDecoderError.decodeFailure, false, nil)
                    return
                }
                
                if decoded.accuracy == nil && decoded.statusCode == 500 && decoded.result == nil {
                    completion(error, false, nil)
                }
                completion(nil, true, decoded)
            }
    }
}
