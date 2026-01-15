//
//  DIContainer.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 3.01.2026.
//

import Foundation

struct DIContainer {
    let authentication: ECAuthenticationProtocol
    
    init() {
        self.authentication = ECAuthentication()
    }
}
