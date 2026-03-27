//
//  ECNetworkService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

protocol NetworkServiceProtocol {
    var application: ApplicationAPISubServiceProtocol { get }
    var accountDeletion: AccountDeletionAPISubServiceProtocol { get }
    var passwordReset: PasswordResetAPISubServiceProtocol { get }
    var authentication: AuthAPISubServiceProtocol { get }
    var references: ReferencesAPISubServiceProtocol { get }
    var news: NewsAPISubServiceProtocol { get }
    var university: UniversityAPISubServiceProtocol { get }
    var professions: ProfessionsAPISubServiceProtocol { get }
    var programs: ProgramsAPISubServiceProtocol { get }
    var profile: ProfileAPISubServiceProtocol { get }
}

final class ECNetworkService: NetworkServiceProtocol {
    let authentication: AuthAPISubServiceProtocol
    let accountDeletion: AccountDeletionAPISubServiceProtocol
    let references: ReferencesAPISubServiceProtocol
    let news: NewsAPISubServiceProtocol
    let university: UniversityAPISubServiceProtocol
    let programs: ProgramsAPISubServiceProtocol
    let professions: ProfessionsAPISubServiceProtocol
    let profile: ProfileAPISubServiceProtocol
    let application: ApplicationAPISubServiceProtocol
    let passwordReset: PasswordResetAPISubServiceProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.authentication = AuthAPISubService(httpClient: httpClient)
        self.references = ReferencesAPISubService(httpClient: httpClient)
        self.university = UniversityAPISubService(httpClient: httpClient)
        self.programs = ProgramsAPISubService(httpClient: httpClient)
        self.professions = ProfessionsAPISubService(httpClient: httpClient)
        self.news = NewsAPISubService(httpClient: httpClient)
        self.profile = ProfileAPISubService(httpClient: httpClient)
        self.application = ApplicationAPISubService(httpClient: httpClient)
        self.accountDeletion = AccountDeletionAPISubService(httpClient: httpClient)
        self.passwordReset = PasswordResetAPISubService(httpClient: httpClient)
    }
}
