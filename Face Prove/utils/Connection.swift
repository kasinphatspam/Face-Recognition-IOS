//
//  Connection.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

class Connection {
    
    func gets(from: String, header: [String: String]?, completion: @escaping ((Error?, Bool, Data?) -> Void)) async throws {
        let url = URL(string: from)!
        
        // create http request, header configuration and payload
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(EnviromentVariable.accessKey)", forHTTPHeaderField:"access-key")
        // specific (isOptional)
        if header != nil {
            header?.forEach({ (key: String, value: String) in
                addHeader(field: key, value: value)
            })
        }
        request.httpMethod = "GET"
        
        // retrive the response and call it back
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, false , nil)
                return
            }
            completion(nil, true, data)
        }
        task.resume()
        
        func addHeader(field: String, value: String) {
            request.addValue(value, forHTTPHeaderField: field)
        }
    }
    
    func posts(from: String, parameter: [String: Any]?, header: [String: String]?, completion: @escaping ((Error?, Bool, Data?) -> Void)) async throws {
        let url = URL(string: from)!
        
        // create http request, header configuration and payload
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(EnviromentVariable.accessKey)", forHTTPHeaderField:"access-key")
        // specific (isOptional)
        if header != nil {
            header?.forEach({ (key: String, value: String) in
                addHeader(field: key, value: value)
            })
        }
        request.httpMethod = "POST"
        
        // convert the data from [String: Any] to JSON
        if parameter != nil {
            let body = try? JSONSerialization.data(withJSONObject: parameter!)
            request.httpBody = body
        }
        
        // retrive the response and call it back
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, false , nil)
                return
            }
            completion(nil, true, data)
        }
        task.resume()
        
        func addHeader(field: String, value: String) {
            request.addValue(value, forHTTPHeaderField: field)
        }
    }
    
    func puts(from: String, parameter: [String: Any]?, header: [String: String]?, completion: @escaping ((Error?, Bool, Data?) -> Void)) async throws {
        let url = URL(string: from)!
        
        // create http request, header configuration and payload
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(EnviromentVariable.accessKey)", forHTTPHeaderField:"access-key")
        // specific (isOptional)
        if header != nil {
            header?.forEach({ (key: String, value: String) in
                addHeader(field: key, value: value)
            })
        }
        request.httpMethod = "PUT"
        
        // convert the data from [String: Any] to JSON
        if parameter != nil {
            let body = try? JSONSerialization.data(withJSONObject: parameter!)
            request.httpBody = body
        }
        
        // retrive the response and call it back
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, false , nil)
                return
            }
            completion(nil, true, data)
        }
        task.resume()
        
        func addHeader(field: String, value: String) {
            request.addValue(value, forHTTPHeaderField: field)
        }
    }
    
    func delete(from: String, parameter: [String: Any]?, header: [String: String]?, completion: @escaping ((Error?, Bool, Data?) -> Void)) async throws {
        let url = URL(string: from)!
        
        // create http request, header configuration and payload
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(EnviromentVariable.accessKey)", forHTTPHeaderField:"access-key")
        // specific (isOptional)
        if header != nil {
            header?.forEach({ (key: String, value: String) in
                addHeader(field: key, value: value)
            })
        }
        request.httpMethod = "DELETE"
        
        // convert the data from [String: Any] to JSON
        if parameter != nil {
            let body = try? JSONSerialization.data(withJSONObject: parameter!)
            request.httpBody = body
        }
        
        // retrive the response and call it back
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, false , nil)
                return
            }
            completion(nil, true, data)
        }
        task.resume()
        
        func addHeader(field: String, value: String) {
            request.addValue(value, forHTTPHeaderField: field)
        }
    }
}
