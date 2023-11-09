//
//  contacts.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import Foundation

struct Contact: Codable {
    let firstname: String?
    let lastname: String?
    let contactCompany: String?
    let title: String?
    let officePhone: String?
    let mobile: String?
    let email1: String?
    let email2: String?
    let dob: Date?
    let contactOwner: String?
    let createdTime: Date?
    let lineId: String?
    let facebook: String?
    let linkedIn: String?
    let image: String?
    let organization: Organization?
}
