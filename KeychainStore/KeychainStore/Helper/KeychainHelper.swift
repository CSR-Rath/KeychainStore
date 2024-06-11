//
//  KeychainHelper.swift
//  KeychainStore
//
//  Created by Rath! on 11/6/24.
//

import Foundation
import Security

class KeychainHelper {
    
//    static func storeData (data: Data, forService service: String, account: String) -> Bool {
//        let query: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrService as String: service,
//            kSecAttrAccount as String: account,
//            kSecValueData as String: data
//        ]
//        let status = SecItemAdd (query as CFDictionary, nil)
//        return status == errSecSuccess
//    }
    
    static func storeData(data: Data, forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            print("updateData")
            return updateData(data: data, forService: service, account: account)
        } else {
            return false
        }
    }
    
    static func getData(forService service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var itemData: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemData)
        
        if status == errSecSuccess, let data = itemData as? Data, let password = String(data: data, encoding: .utf8) {
            return password
        } else {
            return nil
        }
    }
    
    static func deleteData(forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    private static func updateData(data: Data, forService service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status == errSecSuccess
    }
}
