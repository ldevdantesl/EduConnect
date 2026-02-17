//
//  ProgramsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit

protocol ProgramsScreenPresenterProtocol: AnyObject {
    func didTapTabBar()
    func didTapAccount()
    func viewDidLoad()
    func didTapAppLogo()
    func didReceivePrograms(_ programs: [ECProgramCategory])
    func didReceieveError(error: any Error)
}

final class ProgramsScreenPresenter {
    // MARK: - VIPER
    weak var view: ProgramsScreenViewProtocol?
    var router: ProgramsScreenRouterProtocol
    var interactor: ProgramsScreenInteractorProtocol
    private let errorService: ErrorServiceProtocol
    
    // MARK: - PROPERTIES
    private var programs: [ECProgramCategory] = []
    private lazy var headerVM = ProgramsScreenHeaderCellViewModel()
    private lazy var footerVM = TabsFooterCellViewModel(
        titleLabelText: "Направления обучения в бакалавриате и специалитете",
        subtitleLabelText: "Выбери интересное тебе направление образования в вузе и получи список программ бакалавриата и специалитета по требуемому направлению обучения. Ты узнаешь в каких вузах есть соответствующие программы по направлению подготовки, какие требуются экзамены, минимальные и проходные баллы, стоимость обучения. В этом списке ты можешь найти интересную сферу деятельности, отрасль, направление обучения и узнать детали поступления в вуз."
    )

    init(interactor: ProgramsScreenInteractorProtocol, router: ProgramsScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    // MARK: - PRIVATE FUNC
    private func initialSnapshot() {
        view?.applySnapshot(
            sections: [.header, .footer],
            itemsBySection: [
                .header: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .loadingItem(.init(id: "loading", viewModel: LoadingCellViewModel()))
                ],
                .footer: [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }

    private func applyProgramsToView() {
        let programItems = programs.map {
            ProgramsScreenItem.programItem(
                .init(id: $0.id, viewModel: ProgramsScreenProgramCellViewModel(programTitle: $0.name.ru, programImageURL: $0.iconURL))
            )
        }
        
        view?.applySnapshot(
            sections: [.header, .programs, .footer],
            itemsBySection: [
                .header: [.headerItem(.init(id: "header", viewModel: headerVM))],
                .programs: programItems,
                .footer: [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }
}

extension ProgramsScreenPresenter: ProgramsScreenPresenterProtocol {
    func viewDidLoad() {
        initialSnapshot()
        interactor.getPrograms()
        print("Loading")
    }
    
    func didReceivePrograms(_ programs: [ECProgramCategory]) {
        print("Got programs")
        self.programs = programs
        applyProgramsToView()
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didReceieveError(error: any Error) {
        let userFacingError = errorService.handle(error)
        self.view?.showError(errorMessage: userFacingError.message)
    }
}
