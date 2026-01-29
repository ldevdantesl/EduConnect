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
    let networkService: ECNetworkService
    let errorService: ECErrorService
    
    init() {
        let logger = ECNetworkLogger()
        let httpClient = HTTPClient(logger: logger)
        let tokenStorage = TokenStorage()
        self.authentication = ECAuthentication()
        self.sidebarService = ECSidebarService()
        self.errorService = ECErrorService()
        self.networkService = ECNetworkService(httpClient: httpClient, tokenStorage: tokenStorage)
    }
}
