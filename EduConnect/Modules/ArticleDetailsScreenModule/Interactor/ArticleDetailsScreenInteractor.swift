//
//  ArticleDetailsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit

protocol ArticleDetailsScreenInteractorProtocol: AnyObject {
    func getRelated(article: ECNews)
}

final class ArticleDetailsScreenInteractor: ArticleDetailsScreenInteractorProtocol {
    weak var presenter: ArticleDetailsScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getRelated(article: ECNews) {
        Task {
            do {
                let related = try await networkService.news.getRelatedForNews(newsID: article.id, limit: nil)
                presenter?.didReceiveRelatedNews(related)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
