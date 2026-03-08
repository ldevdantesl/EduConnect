//
//  ArticlesScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit

protocol ArticlesScreenInteractorProtocol: AnyObject {
    func getNewsTypes()
    func getAllNews()
    func getNewsForType(typeID: Int?, page: Int?)
}

final class ArticlesScreenInteractor: ArticlesScreenInteractorProtocol {
    weak var presenter: ArticlesScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
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
    
    func getNewsForType(typeID: Int?, page: Int?) {
        Task {
            do {
                let response: PaginatedResponse<ECNews> = try await networkService.news.getNews(newsTypeID: typeID?.description, universityID: nil, itemsPerPage: nil, page: page)
                presenter?.didReceiveNewsForType(response: response, typeID: typeID)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getAllNews() {
        Task {
            do {
                let response: PaginatedResponse<ECNews> = try await networkService.news.getNews(newsTypeID: nil, universityID: nil, itemsPerPage: nil, page: nil)
                presenter?.didReceiveAllNews(response: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
