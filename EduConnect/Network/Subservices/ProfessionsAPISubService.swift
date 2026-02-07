//
//  ProfessionsAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

protocol ProfessionsAPISubServiceProtocol {
    func getProfessions(searchText: String) 
    func getProfessionDetails(professionID: Int)
    func getRelatedForProfession(professionID: Int, limit: Int)
    func getUniversitiesForProfession(professionID: Int, itemsPerPage: Int)
    func getProgramsForProfession(professionID: Int, itemsPerPage: Int)
}

final class ProfessionsAPISubService: ProfessionsAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func getProfessions(searchText: String) {
    }
    
    func getProfessionDetails(professionID: Int) {
        <#code#>
    }
    
    func getRelatedForProfession(professionID: Int, limit: Int) {
        <#code#>
    }
    
    func getUniversitiesForProfession(professionID: Int, itemsPerPage: Int) {
        <#code#>
    }
    
    func getProgramsForProfession(professionID: Int, itemsPerPage: Int) {
        <#code#>
    }
    
}
