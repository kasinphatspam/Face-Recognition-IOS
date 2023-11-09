//
//  Connection.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

class Connection {
    
    func gets(from: String) async throws -> Data {
        let url = URL(string: from)!
        let (data,_) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func posts(from: String, parameter: [String: Any]) async throws -> URLRequest{
        let url = URL(string: from)!
        let body = try? JSONSerialization.data(withJSONObject: parameter)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = body
        
        return request
    }
}
