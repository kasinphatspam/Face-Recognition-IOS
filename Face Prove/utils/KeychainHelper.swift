//
//  KeychainHelper.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 18/11/2566 BE.
//

import Foundation
import Security

class KeychainHelper {
    static func storeDate(data: Data, forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    static func updateData(data: Data, forService service: String, account: String) -> Bool {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary

        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        // Update existing item
        let status = SecItemUpdate(query, attributesToUpdate)
        return status == errSecSuccess
    }
    
    static func retrivedData(forService service: String, account: String) -> Data? {
        let query: [String: Any] = [
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        return (result as? Data)
    }
    
    static func deleteData(forService service: String, account: String) -> Bool {
        let query = [
            kSecAttrService: EnviromentVariable.service,
            kSecAttrAccount: EnviromentVariable.account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // delete item from keychain
        let status = SecItemDelete(query)
        return status == errSecSuccess
    }
}
