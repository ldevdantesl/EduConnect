//
//  UniversityInfoScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

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
        let contactsVM = UniversityInfoScreenContactsCellViewModel(university: university)
        let facultiesHeaderVM = SectionHeaderCellViewModel(title: "Факультеты", titleSize: 22, titleAlignment: .center)
        let programsHeaderVM = SectionHeaderCellViewModel(title: "Программы образования", titleSize: 22, titleAlignment: .center)
        let professionsHeaderVM = SectionHeaderCellViewModel(title: "Профессии", titleSize: 22, titleAlignment: .center)
        let articlesHeaderVM = SectionHeaderCellViewModel(title: "Новости", titleSize: 22, titleAlignment: .center)
        view?.applySnapshot(
            sections: [.header, .main, .faculties, .programs, .professions, .articles],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .main : [
                    .averageENTScoreItem(.init(id: "averageENTCells", viewModel: entScoresVM)),
                    .aboutItem(.init(id: "about", viewModel: aboutVM)),
                    .contactsItem(.init(id: "contacts", viewModel: contactsVM))
                ],
                .faculties : [
                    .sectionHeaderItem(.init(id: "facultiesHeader", viewModel: facultiesHeaderVM))
                ],
                .programs : [
                    .sectionHeaderItem(.init(id: "programsHeader", viewModel: programsHeaderVM))
                ],
                .professions : [
                    .sectionHeaderItem(.init(id: "professionsHeader", viewModel: professionsHeaderVM))
                ],
                .articles : [
                    .sectionHeaderItem(.init(id: "articlesHeader", viewModel: articlesHeaderVM))
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
