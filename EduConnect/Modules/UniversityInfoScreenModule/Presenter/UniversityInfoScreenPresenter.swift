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
    func didTapAppLogo()
    func didTapBack()
    func didReceiveUniversity(university: ECUniversity)
    func didReceieveError(error: any Error)
}

final class UniversityInfoScreenPresenter {
    weak var view: UniversityInfoScreenViewProtocol?
    var router: UniversityInfoScreenRouterProtocol
    var interactor: UniversityInfoScreenInteractorProtocol
    
    private let errorService: ErrorServiceProtocol
    private let universityID: Int
    private var university: ECUniversity?

    init(
        interactor: UniversityInfoScreenInteractorProtocol,
        router: UniversityInfoScreenRouterProtocol,
        errorService: ErrorServiceProtocol,
        university: ECUniversity
    ) {
        self.interactor = interactor
        self.errorService = errorService
        self.router = router
        self.universityID = university.id
        self.university = university
    }
    
    init(
        interactor: UniversityInfoScreenInteractorProtocol,
        router: UniversityInfoScreenRouterProtocol,
        errorService: ErrorServiceProtocol,
        universityID: Int
    ) {
        self.interactor = interactor
        self.errorService = errorService
        self.router = router
        self.universityID = universityID
    }
    
    private func applySnapshot() {
        guard let university = university else { return }
        let headerVM = UniversityInfoScreenHeaderCellViewModel(university: university)
        let entScoresVM = UniversityInfoScreenAverageEntCellViewModel(entScores: university.entScores ?? [])
        let aboutVM = UniversityInfoScreenAboutCellViewModel(university: university)
        let contactsVM = UniversityInfoScreenContactsCellViewModel(university: university)
        
        let facultiesHeaderVM = SectionHeaderCellViewModel(title: "Факультеты", titleSize: 22, titleAlignment: .center)
        var facultyItems: [UniversityInfoScreenItem] = []
        facultyItems.append(.sectionHeaderItem(.init(id: "facultiesHeader", viewModel: facultiesHeaderVM)))
        
        university.faculties.forEach {
            let vm = CardWithImageCellViewModel(imageURL: $0.imageURL, title: $0.name)
            facultyItems.append(.cardItem(.init(id: "faculty-\($0.id)", viewModel: vm)))
        }
        
        let programsHeaderVM = SectionHeaderCellViewModel(title: "Программы образования", titleSize: 22, titleAlignment: .center)
        var programItems: [UniversityInfoScreenItem] = []
        programItems.append(.sectionHeaderItem(.init(id: "programsHeader", viewModel: programsHeaderVM)))
        university.programs.forEach {
            let vm = CardWithImageCellViewModel(
                imageURL: university.logoURL,
                imageContentMode: .scaleAspectFit, title: $0.name,
                subtitle: "\($0.budgetPlaces) бюджет. мест, \($0.paidPlaces) платн. мест, \($0.studyTypeName) обучение"
            )
            programItems.append(.cardItem(.init(id: "program-\($0.id)", viewModel: vm)))
        }
        
        let professionsHeaderVM = SectionHeaderCellViewModel(title: "Профессии", titleSize: 22, titleAlignment: .center)
        var professionItems: [UniversityInfoScreenItem] = []
        professionItems.append(.sectionHeaderItem(.init(id: "professionsHeader", viewModel: professionsHeaderVM)))
        
        university.professions.forEach {
            let vm = CardWithImageCellViewModel(imageURL: $0.imageURL, title: $0.name)
            professionItems.append(.cardItem(.init(id: "profession-\($0.id)", viewModel: vm)))
        }
        
        view?.applySnapshot(
            sections: [.header, .main, .faculties, .programs, .professions],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .main : [
                    .averageENTScoreItem(.init(id: "averageENTCells", viewModel: entScoresVM)),
                    .aboutItem(.init(id: "about", viewModel: aboutVM)),
                    .contactsItem(.init(id: "contacts", viewModel: contactsVM))
                ],
                .faculties : facultyItems,
                .programs : programItems,
                .professions : professionItems,
            ]
        )
    }
}

extension UniversityInfoScreenPresenter: UniversityInfoScreenPresenterProtocol {
    func viewDidLoad() {
        if university == nil {
            self.view?.showLoading()
            self.interactor.getUniversityByID(id: universityID)
            return
        } else {
            applySnapshot()
        }
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
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    
    func didReceiveUniversity(university: ECUniversity) {
        self.university = university
        applySnapshot()
        self.view?.hideLoading()
    }
    
    func didReceieveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(errorMessage: userError.message)
    }
}
