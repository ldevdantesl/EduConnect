//
//  ProfileAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 16.02.2026.
//

import Foundation

protocol ProfileAPISubServiceProtocol {
    @discardableResult
    func updatePersonal(surname: String?, name: String?, patronymic: String?, phoneNumber: String?) async throws -> EduConnectResponse
    
    @discardableResult
    func updateEducation(institution: String?, finalClass: String?, score: Double?) async throws  -> EduConnectResponse
    
    @discardableResult
    func updateETHYear(year: Int) async throws -> EduConnectResponse
    
    @discardableResult
    func addETHSubjects(subjectID: Int, score: String) async throws -> EduConnectResponse
    
    @discardableResult
    func deleteETHSubject(subjectID: Int) async throws -> EduConnectResponse
    
    @discardableResult
    func addFamilyMember(familyMemberID: Int, fullName: String, phoneNumber: String) async throws -> EduConnectResponse
    
    @discardableResult
    func deleteFamilyMember(familyMemberID: Int) async throws -> EduConnectResponse
    
    @discardableResult
    func addOlympiad(olympiadTypeID: Int, olympiadPlaceID: Int, year: String) async throws -> EduConnectResponse
    @discardableResult
    func deleteOlympiad(olympiadID: Int) async throws -> EduConnectResponse
    
    @discardableResult
    func addExtracurricular(activityID: Int, description: String?) async throws -> EduConnectResponse
    
    @discardableResult
    func deleteExtracurricular(activityID: Int) async throws -> EduConnectResponse
}

final class ProfileAPISubService: ProfileAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func updatePersonal(surname: String?, name: String?, patronymic: String?, phoneNumber: String?) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.updatePersonal(surname: surname, name: name, patronymic: patronymic, phoneNumber: phoneNumber))
    }
    
    func updateEducation(institution: String?, finalClass: String?, score: Double?) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.updateEducation(institution: institution, finalClass: finalClass, score: score))
    }
    
    func updateETHYear(year: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.updateETHYear(year: year))
    }
    
    func addETHSubjects(subjectID: Int, score: String) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.addETHSubjects(subjectID: subjectID, score: score))
    }
    
    func deleteETHSubject(subjectID: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.deleteETHSubject(subjectID: subjectID))
    }
    
    func addFamilyMember(familyMemberID: Int, fullName: String, phoneNumber: String) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.addFamilyMember(familyMemberID: familyMemberID, fullName: fullName, phoneNumber: phoneNumber))
    }
    
    func deleteFamilyMember(familyMemberID: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.deleteFamilyMember(familyMemberID: familyMemberID))
    }
    
    func addOlympiad(olympiadTypeID: Int, olympiadPlaceID: Int, year: String) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.addOlympiad(olympiadTypeID: olympiadTypeID, olympiadPlaceID: olympiadPlaceID, year: year))
    }
    
    func deleteOlympiad(olympiadID: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.deleteOlympiad(olympiadID: olympiadID))
    }
    
    func addExtracurricular(activityID: Int, description: String?) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.addExtracurricular(activityID: activityID, description: description))
    }
    
    func deleteExtracurricular(activityID: Int) async throws -> EduConnectResponse {
        try await httpClient.request(ProfileEndpoints.deleteExtracurricular(activityID: activityID))
    }
}
