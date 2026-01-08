//
//  LoginScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

protocol LoginScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class LoginScreenPresenter {
    weak var view: LoginScreenViewProtocol?
    var router: LoginScreenRouterProtocol
    var interactor: LoginScreenInteractorProtocol

    private var dataSource: LoginScreenDataSource?
    
    init(interactor: LoginScreenInteractorProtocol, router: LoginScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension LoginScreenPresenter: LoginScreenPresenterProtocol {
    func viewDidLoad() {
        let items = [
            LoginScreenRegistrationCellViewModel { print("Tapped Send Code") }
        ]
        let dataSource = LoginScreenDataSource(items: items)
        self.dataSource = dataSource
        self.view?.configureCollectionView(dataSource: dataSource)
    }
}
