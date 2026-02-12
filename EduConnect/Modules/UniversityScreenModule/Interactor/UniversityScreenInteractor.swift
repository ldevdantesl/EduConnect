//
//  UniversityScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

protocol UniversityScreenInteractorProtocol: AnyObject {
    func getUniversities(page: Int, searchKey: String?, filters: UniversityFilters? )
    func getAllCities()
    func getAllProfessions()
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
            } catch { await handleError(error) }
        }
    }
    
    func getAllCities() {
        Task {
            do {
                let cities = try await networkService.references.getCities()
                presenter?.didGetCities(cities: cities)
            } catch { await handleError(error) }
        }
    }
    
    func getAllProfessions() {
        Task {
            do {
                let professions = try await networkService.references.getProfessions()
                presenter?.didGetProfessions(professions: professions)
            } catch { await handleError(error) }
        }
    }
    
    private func handleError(_ error: Error) async {
        await MainActor.run { [weak self] in
            self?.presenter?.didReceiveError(error: error)
        }
    }
}
