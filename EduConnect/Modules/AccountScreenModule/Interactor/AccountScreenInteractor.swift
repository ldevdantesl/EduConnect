//
//  HomeScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

protocol AccountScreenInteractorProtocol: AnyObject {
    
}

final class AccountScreenInteractor: AccountScreenInteractorProtocol {
    weak var presenter: AccountScreenPresenterProtocol?
}
