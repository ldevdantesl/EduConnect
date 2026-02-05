//
//  MainScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

protocol MainScreenInteractorProtocol: AnyObject {
}

final class MainScreenInteractor: MainScreenInteractorProtocol {
    weak var presenter: MainScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
