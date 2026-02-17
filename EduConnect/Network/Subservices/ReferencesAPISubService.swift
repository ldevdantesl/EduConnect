//
//  ReferencesAPIService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

protocol ReferencesAPISubServiceProtocol {
    func getCities() async throws -> [ECCity]
    func getFaculties() async throws -> [ECFaculty]
    func getProgramCategories() async throws -> [ECProgramCategory]
    func getProfessions() async throws -> [ECReferenceProfession]
    func getFamilyMembers() async throws -> [ECFamilyMember]
    func getSpecialConditions() async throws -> [ECSpecialCondition]
    func getOlympiadTypes() async throws -> [ECOlympiadType]
    func getOlympiadPlaces() async throws -> [ECOlympiadPlace]
    func getSubjects() async throws -> [ENTSubject]
    func getExtracurricularActivities() async throws -> [ECExtracurricularActivity]
}

final class ReferencesAPISubService: ReferencesAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getCities() async throws -> [ECCity] {
        try await httpClient.request(ReferencesEndpoints.getCities)
    }
    
    func getFaculties() async throws -> [ECFaculty] {
        try await httpClient.request(ReferencesEndpoints.getFaculties)
    }
    
    func getProgramCategories() async throws -> [ECProgramCategory] {
        try await httpClient.request(ReferencesEndpoints.getProgramCategories)
    }
    
    func getProfessions() async throws -> [ECReferenceProfession] {
        try await httpClient.request(ReferencesEndpoints.getProfessions)
    }
    
    func getFamilyMembers() async throws -> [ECFamilyMember] {
        try await httpClient.request(ReferencesEndpoints.getFamilyMembers)
    }
    
    func getSpecialConditions() async throws -> [ECSpecialCondition] {
        try await httpClient.request(ReferencesEndpoints.getSpecialConditions)
    }
    
    func getOlympiadTypes() async throws -> [ECOlympiadType] {
        try await httpClient.request(ReferencesEndpoints.getOlympiadTypes)
    }
    
    func getOlympiadPlaces() async throws -> [ECOlympiadPlace] {
        try await httpClient.request(ReferencesEndpoints.getOlympiadPlaces)
    }
    
    func getSubjects() async throws -> [ENTSubject] {
        try await httpClient.request(ReferencesEndpoints.getSubjects)
    }
    
    func getExtracurricularActivities() async throws -> [ECExtracurricularActivity] {
        try await httpClient.request(ReferencesEndpoints.getExtracurricularActivities)
    }
}
