//
//  UniversityAPIService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import UIKit

protocol UniversityAPISubServiceProtocol {
    func getUniversities(page: Int, searchKey: String?, filters: UniversityFilters?) async throws -> PaginatedResponse<ECUniversity>
    func getUniversity(id: Int) async throws -> ECUniversity?
}

final class UniversityAPISubService: UniversityAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getUniversities(page: Int, searchKey: String?, filters: UniversityFilters?) async throws -> PaginatedResponse<ECUniversity> {
        let responseData: EduConnectDataResponse<PaginatedResponse<ECUniversity>> = try await httpClient.request(
            UniversityEndpoints.getUniversities(page: page, search: searchKey, filters: filters)
        )
        return responseData.data
    }
    
    
    func getUniversity(id: Int) async throws -> ECUniversity? {
        let responseData: EduConnectDataResponse<ECUniversity> = try await httpClient.request(
            UniversityEndpoints.getUniversity(id: id)
        )
        return responseData.data 
    }
}
