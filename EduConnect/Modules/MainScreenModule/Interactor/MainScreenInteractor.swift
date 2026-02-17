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
    func getNewsTypes()
    func getNewsForNewsType(typeID: Int?)
    func getAllNews()
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
                presenter?.didReceiveProgramCategories(categories: response)
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
                let response: [ECProfession] = try await networkService.professions.getProfessions(searchText: nil, page: 1) 
                presenter?.didReceiveProfessions(professions: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getNewsTypes() {
        Task {
            do {
                let response = try await networkService.news.getNewsTypes()
                presenter?.didReceiveNewsTypes(types: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getNewsForNewsType(typeID: Int?) {
        Task {
            do {
                let response = try await networkService.news.getNews(newsTypeID: typeID?.description, universityID: nil, itemsPerPage: 3)
                presenter?.didReceiveNewsForType(news: response, typeID: typeID)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getAllNews() {
        Task {
            do {
                let response = try await networkService.news.getNews(newsTypeID: nil, universityID: nil, itemsPerPage: 3)
                presenter?.didReceiveAllNews(news: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
