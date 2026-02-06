//
//  ProgramsAPIService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

protocol ProgramsAPIServiceProtocol {
    func getProgramCategories() async throws -> EduConnectDataResponse<[ECProgramCategory]>
    func getProgramsOfCategory(categoryID: Int) async throws -> EduConnectDataResponse<[ECProgram]>
    func getAllPrograms() async throws  -> EduConnectDataResponse<[ECProgram]>
    func getProgramDetails(programID: Int) async throws  -> EduConnectDataResponse<[ECProgramDetails]>
    func getRelatedProgramsForProgramID(programID: Int, limit: Int) async throws -> EduConnectDataResponse<[ECProgram]>
}

final class ProgramsAPIService: ProgramsAPIServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getProgramCategories() async throws -> EduConnectDataResponse<[ECProgramCategory]> {
        try await httpClient.request(ProgramEndpoints.getProgramCategories)
    }
    
    func getProgramsOfCategory(categoryID: Int) async throws -> EduConnectDataResponse<[ECProgram]> {
        try await httpClient.request(ProgramEndpoints.getProgramsOfCategory(categorieID: categoryID))
    }
    
    func getAllPrograms() async throws -> EduConnectDataResponse<[ECProgram]> {
        try await httpClient.request(ProgramEndpoints.getAllPrograms)
    }
    
    func getProgramDetails(programID: Int) async throws -> EduConnectDataResponse<[ECProgramDetails]> {
        try await httpClient.request(ProgramEndpoints.getProgramDetails(programID: programID))
    }
    
    func getRelatedProgramsForProgramID(programID: Int, limit: Int) async throws -> EduConnectDataResponse<[ECProgram]> {
        try await httpClient.request(ProgramEndpoints.getRelatedProgramsForProgramID(programID: programID, limit: limit))
    }
}
