//
//  EnviromentVariable.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 9/11/2566 BE.
//

import Foundation

struct EnviromentVariable {
    // HTTP Configuration
    // For Production
//    static let protocal: String = "https"
//    static let ip: String = "api.pphamster.com"
    // For Develop
    static let protocal: String = "http"
    static let ip: String = "192.168.0.40:3001"
    static let accessKey: String = "7feLDMjmHgUNx8hd4XhmM7Ph2R407N6Rvv1OpILZ6q9hb3bfx5DXaUJCNZlUJhjZEnCoh4XrTQHTef47el7ogy4Sl2CLQY18EOT6S1A0cqVMiwNeBOSUQwIKSHX5CNMY"
    
    // Keychain service and account configuration
    // Authentication Session
    static let service: String = "com.faceprove.app.auth"
    static let account: String = "faceprove"
}
