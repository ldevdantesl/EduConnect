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
        let networkSer = ECNetworkService(httpClient: httpClient)
        self.sidebarService = ECSidebarService()
        self.errorService = ECErrorService()
        self.networkService = networkSer
        self.authentication = ECAuthentication(networkService: networkSer, tokenStorage: tokenStorage)
    }
}
