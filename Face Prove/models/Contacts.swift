//
//  contacts.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct Contact: Codable, Identifiable {
    let id: Int
    let firstname: String
    let lastname: String
    let company: String?
    let title: String?
    let officePhone: String?
    let mobile: String
    let email1: String
    let email2: String?
    let dob: String?
    let owner: String?
    let createdTime: String
    let modifiedTime: String
    let lineId: String?
    let facebook: String?
    let linkedin: String?
    let encodedId: String?
    let image: String?
}
