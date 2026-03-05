//
//  ArticlesScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit

protocol ArticlesScreenInteractorProtocol: AnyObject {
}

final class ArticlesScreenInteractor: ArticlesScreenInteractorProtocol {
    weak var presenter: ArticlesScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
