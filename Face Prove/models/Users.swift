//
//  users.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct UsersResponse: Decodable {
    let results: [User]
}

struct User: Codable, Identifiable {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let gender: String?
    let image: String?
    let organization: Organization?
    let role: Role?
}
