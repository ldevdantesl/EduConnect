//
//  UniversityInfoScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

protocol UniversityInfoScreenInteractorProtocol: AnyObject {
    
}

final class UniversityInfoScreenInteractor: UniversityInfoScreenInteractorProtocol {
    weak var presenter: UniversityInfoScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
