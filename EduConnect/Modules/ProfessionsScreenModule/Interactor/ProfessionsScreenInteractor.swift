//
//  ProfessionsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

import Foundation

protocol ProfessionsScreenInteractorProtocol: AnyObject {
    func getProfessions(searchText: String?, sortOption: ProfessionSortOption?, page: Int)
}

final class ProfessionsScreenInteractor: ProfessionsScreenInteractorProtocol {
    weak var presenter: ProfessionsScreenPresenterProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getProfessions(searchText: String?, sortOption: ProfessionSortOption?, page: Int) {
        Task {
            do {
                let response: PaginatedResponse<ECProfession> = try await networkService.professions.getProfessions(searchText: searchText, sortOption: sortOption, page: page)
                presenter?.didReceiveProfessions(response.data, currentPage: response.meta.currentPage, totalPages: response.meta.lastPage)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
