//
//  ApplicationAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

protocol ApplicationAPISubServiceProtocol {
    func getApplications() async throws -> [Application]
    func apply(universityID: Int) async throws -> EduConnectResponse
    func details(applicationID: Int) async throws -> ApplicationDetails
    func delete(applicationID: Int) async throws -> EduConnectResponse
    func applicationStatus(universityID: Int) async throws -> Application
}

final class ApplicationAPISubService: ApplicationAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getApplications() async throws -> [Application] {
        let response: EduConnectDataResponse<[Application]> = try await httpClient.request(ApplicationEndpoints.getApplications)
        return response.data
    }
    
    func apply(universityID: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ApplicationEndpoints.postApplication(universityID: universityID))
    }
    
    func details(applicationID: Int) async throws -> ApplicationDetails {
        try await httpClient.request(ApplicationEndpoints.applicationDetails(applicationID: applicationID))
    }
    
    func delete(applicationID: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ApplicationEndpoints.deleteApplication(applicationID: applicationID))
    }
    
    func applicationStatus(universityID: Int) async throws -> Application {
        let response: EduConnectDataResponse<Application> = try await httpClient.request(ApplicationEndpoints.getApplicationStatus(universityID: universityID))
        return response.data
    }
}
