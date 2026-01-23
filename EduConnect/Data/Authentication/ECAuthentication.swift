//
//  ECAuthentication.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 14.01.2026.
//

import Foundation

final class ECAuthentication: AuthenticationProtocol {
    private var isLoggedInKey = "isLoggedInKey"
    
    var isLoggedIn: Bool {
        ECUserDefaults.get(Bool.self, forKey: isLoggedInKey) ?? false
    }
    
    func logIn() {
        do {
            try ECUserDefaults.save(true, forKey: isLoggedInKey)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func logOut() {
        ECUserDefaults.remove(forKey: isLoggedInKey)
    }
    
    func signIn() { }
}
