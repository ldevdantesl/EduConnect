//
//  UniversityScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

protocol UniversityScreenInteractorProtocol: AnyObject {
    func getUniversities(page: Int, searchKey: String?, filters: UniversityFilters? )
}

final class UniversityScreenInteractor: UniversityScreenInteractorProtocol {
    weak var presenter: UniversityScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getUniversities(page: Int, searchKey: String?, filters: UniversityFilters?) {
        Task {
            do {
                let universitiesPaginated = try await networkService.university.getUniversities(page: page, searchKey: searchKey, filters: filters)
                presenter?.didReceiveUniversities(paginatedUniversities: universitiesPaginated)
            } catch {
                await MainActor.run { [weak self] in
                    self?.presenter?.didReceiveError(error: error)
                }
            }
        }
    }
}
