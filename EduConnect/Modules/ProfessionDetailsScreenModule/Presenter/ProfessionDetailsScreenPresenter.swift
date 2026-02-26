//
//  ProfessionDetailsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit

protocol ProfessionDetailsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func didTapAccount()
    func didTapAppLogo()
    
    func didReceiveProfession(profession: ECProfession)
    func didReceiveRelated(professions: [ECProfession])
    func didReceiveError(error: any Error)
}

final class ProfessionDetailsScreenPresenter {
    // MARK: - VIPER
    weak var view: ProfessionDetailsScreenViewProtocol?
    var router: ProfessionDetailsScreenRouterProtocol
    var interactor: ProfessionDetailsScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let dispatchGroup = DispatchGroup()
    private let errorService: ErrorServiceProtocol
    private let professionID: Int
    private var profession: ECProfession?
    private var related: [ECProfession] = []

    init(interactor: ProfessionDetailsScreenInteractorProtocol, router: ProfessionDetailsScreenRouterProtocol, errorService: ErrorServiceProtocol, professionID: Int) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
        self.professionID = professionID
    }
    
    private func applySnapshot() {
        guard let profession else { return }
        let headerVM = ProfessionDetailsHeaderCellViewModel(profession: profession)
        
        view?.applySnapshot(
            sections: [.header],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))]
            ]
        )
    }
}

extension ProfessionDetailsScreenPresenter: ProfessionDetailsScreenPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        
        dispatchGroup.enter()
        interactor.getProfession(id: professionID)
        
        dispatchGroup.enter()
        interactor.getRelatedProfessions(id: professionID)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.applySnapshot()
        }
    }
    
    func didTapBack() {
        router.goBack()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didReceiveProfession(profession: ECProfession) {
        self.profession = profession
        dispatchGroup.leave()
    }
    
    func didReceiveRelated(professions: [ECProfession]) {
        self.related = professions
        dispatchGroup.leave()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(error: userError)
    }
}
