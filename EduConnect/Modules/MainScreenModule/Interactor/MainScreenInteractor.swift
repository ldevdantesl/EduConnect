//
//  MainScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

protocol MainScreenInteractorProtocol: AnyObject {
    func getProgramCategories()
    func getAllUniversities()
    func getProfessions()
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
    weak var presenter: MainScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getProgramCategories() {
        Task {
            do {
                let response = try await networkService.programs.getProgramCategories()
                guard let data = response.data else { return }
                presenter?.didReceiveProgramCategories(categories: data)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getAllUniversities() {
        Task {
            do {
                let response = try await networkService.university.getUniversities(page: 1, searchKey: nil, filters: nil)
                presenter?.didReceiveUniversities(universities: response.data)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getProfessions() {
        Task {
            do {
                let response = try await networkService.references.getProfessions()
                presenter?.didReceiveProfessions(professions: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
