//
//  ArticleDetailsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit

protocol ArticleDetailsScreenInteractorProtocol: AnyObject {
}

final class ArticleDetailsScreenInteractor: ArticleDetailsScreenInteractorProtocol {
    weak var presenter: ArticleDetailsScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
