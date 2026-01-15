//
//  ECAuthentication.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 14.01.2026.
//

import Foundation

protocol ECAuthenticationProtocol: AnyObject {
    var isLoggedIn: Bool { get }
    
    func logIn()
    func logOut()
    func signIn()
}
