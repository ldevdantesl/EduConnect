//
//  DIContainer.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 3.01.2026.
//

import Foundation

struct DIContainer {
    let authentication: ECAuthentication
    let sidebarService: ECSidebarService
    
    init() {
        self.authentication = ECAuthentication()
        self.sidebarService = ECSidebarService()
    }
}
