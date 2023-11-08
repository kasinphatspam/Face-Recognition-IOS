//
//  users.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct UsersResponse: Decodable {
    let results: [Users]
}

struct Users: Codable {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let gender: String?
    let image: String?
}
