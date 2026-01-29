//
//  ECNetworkService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

protocol NetworkServiceProtocol {
    var authentication: AuthAPIServiceProtocol { get }
    var references: ReferencesAPIServiceProtocol { get }
    var university: UniversityAPIServiceProtocol { get }
}

final class ECNetworkService: NetworkServiceProtocol {
    let authentication: AuthAPIServiceProtocol
    let references: ReferencesAPIServiceProtocol
    let university: UniversityAPIServiceProtocol
    
    init(httpClient: HTTPClientProtocol, tokenStorage: TokenStorageProtocol) {
        self.authentication = AuthAPIService(httpClient: httpClient, tokenStorage: tokenStorage)
        self.references = ReferencesAPIService(httpClient: httpClient)
        self.university = UniversityAPIService(httpClient: httpClient)
    }
}
