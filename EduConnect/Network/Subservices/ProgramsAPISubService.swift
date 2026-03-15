//
//  ProgramsAPIService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

protocol ProgramsAPISubServiceProtocol {
    func getProgramCategories() async throws -> [ECProgramCategory]
    func getProgramsOfCategory(categoryID: Int) async throws -> [ECProgram]
    func getAllPrograms() async throws  -> [ECProgram]
    func getProgramDetails(programID: Int) async throws -> ECProgramDetails
    func getRelatedProgramsForProgramID(programID: Int, limit: Int?) async throws -> [ECProgram]
}

final class ProgramsAPISubService: ProgramsAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getProgramCategories() async throws -> [ECProgramCategory] {
        let response: EduConnectDataResponse<[ECProgramCategory]> = try await httpClient.request(ProgramEndpoints.getProgramCategories)
        return response.data
    }
    
    func getProgramsOfCategory(categoryID: Int) async throws -> [ECProgram] {
        let response: EduConnectDataResponse<[ECProgram]> = try await httpClient.request(ProgramEndpoints.getProgramsOfCategory(categorieID: categoryID))
        return response.data
    }
    
    func getAllPrograms() async throws -> [ECProgram] {
        let response: EduConnectDataResponse<[ECProgram]> = try await httpClient.request(ProgramEndpoints.getAllPrograms)
        return response.data
    }
    
    func getProgramDetails(programID: Int) async throws -> ECProgramDetails {
        let response: EduConnectDataResponse<ECProgramDetails> = try await httpClient.request(ProgramEndpoints.getProgramDetails(programID: programID))
        return response.data
    }
    
    func getRelatedProgramsForProgramID(programID: Int, limit: Int?) async throws -> [ECProgram] {
        let response: EduConnectDataResponse<[ECProgram]> = try await httpClient.request(ProgramEndpoints.getRelatedProgramsForProgramID(programID: programID, limit: limit))
        return response.data
    }
}
