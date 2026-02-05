//
//  UniversityInfoScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

protocol UniversityInfoScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAccount()
    func didTapBack()
}

final class UniversityInfoScreenPresenter {
    weak var view: UniversityInfoScreenViewProtocol?
    var router: UniversityInfoScreenRouterProtocol
    var interactor: UniversityInfoScreenInteractorProtocol
    
    private let errorService: ErrorServiceProtocol
    private let university: ECUniversity

    init(
        interactor: UniversityInfoScreenInteractorProtocol,
        router: UniversityInfoScreenRouterProtocol,
        errorService: ErrorServiceProtocol, university: ECUniversity
    ) {
        self.interactor = interactor
        self.errorService = errorService
        self.router = router
        self.university = university
    }
}

extension UniversityInfoScreenPresenter: UniversityInfoScreenPresenterProtocol {
    func viewDidLoad() {
        let headerVM = UniversityInfoScreenHeaderCellViewModel(university: university)
        let entScoresVM = UniversityInfoScreenAverageEntCellViewModel(entScores: university.entScores ?? [])
        let aboutVM = UniversityInfoScreenAboutCellViewModel(university: university)
        view?.applySnapshot(
            sections: [.header, .main],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .main : [
                    .averageENTScoreItem(.init(id: "averageENTCells", viewModel: entScoresVM)),
                    .aboutItem(.init(id: "about", viewModel: aboutVM))
                ]
            ]
        )
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapBack() {
        router.goBack()
    }
}
