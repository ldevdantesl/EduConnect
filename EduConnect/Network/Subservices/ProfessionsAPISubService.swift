//
//  ProfessionsAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

protocol ProfessionsAPISubServiceProtocol {
    func getProfessions(searchText: String?) async throws -> [ECProfession]
    func getProfessionDetails(professionID: Int) async throws -> ECProfession
    func getRelatedForProfession(professionID: Int, limit: Int) async throws -> [ECProfession]
    func getUniversitiesForProfession(professionID: Int, itemsPerPage: Int) async throws -> [ECUniversity]
    func getProgramsForProfession(professionID: Int, itemsPerPage: Int) async throws -> [ECProgram]
}

final class ProfessionsAPISubService: ProfessionsAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getProfessions(searchText: String?) async throws -> [ECProfession] {
        let profession: EduConnectDataResponse<[ECProfession]> = try await httpClient.request(ProfessionEndpoints.getProfessions(searchText: searchText))
        return profession.data
    }
    
    func getProfessionDetails(professionID: Int) async throws -> ECProfession {
        let professionDetails: EduConnectDataResponse<ECProfession> = try await httpClient.request(ProfessionEndpoints.getProfessionDetails(professionID: professionID))
        return professionDetails.data 
    }
    
    func getRelatedForProfession(professionID: Int, limit: Int) async throws -> [ECProfession] {
        let related: EduConnectDataResponse<[ECProfession]> = try await httpClient.request(ProfessionEndpoints.getRelatedForProfession(professionID: professionID, limit: limit))
        return related.data
    }
    
    func getUniversitiesForProfession(professionID: Int, itemsPerPage: Int) async throws -> [ECUniversity] {
        let unis: EduConnectDataResponse<[ECUniversity]> = try await httpClient.request(ProfessionEndpoints.getUniversitiesForProfession(professionID: professionID, itemsPerPage: itemsPerPage))
        return unis.data
    }
    
    func getProgramsForProfession(professionID: Int, itemsPerPage: Int) async throws -> [ECProgram] {
        let programs: EduConnectDataResponse<[ECProgram]> = try await httpClient.request(ProfessionEndpoints.getProgramsForProfession(professionID: professionID, itemsPerPage: itemsPerPage))
        return programs.data
    }
}
