//
//  ECNetworkService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

protocol NetworkServiceProtocol {
    var authentication: AuthAPISubServiceProtocol { get }
    var references: ReferencesAPISubServiceProtocol { get }
    var university: UniversityAPISubServiceProtocol { get }
    var professions: ProfessionsAPISubServiceProtocol { get }
    var programs: ProgramsAPISubServiceProtocol { get }
}

final class ECNetworkService: NetworkServiceProtocol {
    let authentication: AuthAPISubServiceProtocol
    let references: ReferencesAPISubServiceProtocol
    let university: UniversityAPISubServiceProtocol
    let programs: ProgramsAPISubServiceProtocol
    let professions: any ProfessionsAPISubServiceProtocol
    
    init(httpClient: HTTPClientProtocol, tokenStorage: TokenStorageProtocol) {
        self.authentication = AuthAPISubService(httpClient: httpClient, tokenStorage: tokenStorage)
        self.references = ReferencesAPISubService(httpClient: httpClient)
        self.university = UniversityAPISubService(httpClient: httpClient)
        self.programs = ProgramsAPISubService(httpClient: httpClient)
        self.professions = ProfessionsAPISubService(httpClient: httpClient)
    }
}
