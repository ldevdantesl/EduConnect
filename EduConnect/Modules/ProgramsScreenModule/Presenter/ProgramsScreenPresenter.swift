//
//  ProgramsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

protocol ProgramsScreenPresenterProtocol: AnyObject {
    func didTapTabBar()
    func didTapAccount()
    func viewDidLoad()
}

final class ProgramsScreenPresenter {
    weak var view: ProgramsScreenViewProtocol?
    var router: ProgramsScreenRouterProtocol
    var interactor: ProgramsScreenInteractorProtocol

    init(interactor: ProgramsScreenInteractorProtocol, router: ProgramsScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProgramsScreenPresenter: ProgramsScreenPresenterProtocol {
    func viewDidLoad() {
        let headerVM = ProgramsScreenHeaderCellViewModel()
        let footerVM = TabsFooterCellViewModel(
            titleLabelText: "Направления обучения в бакалавриате и специалитете",
            subtitleLabelText: "Выбери интересное тебе направление образования в вузе и получи список программ бакалавриата и специалитета по требуемому направлению обучения. Ты узнаешь в каких вузах есть соответствующие программы по направлению подготовки, какие требуются экзамены, минимальные и проходные баллы, стоимость обучения. В этом списке ты можешь найти интересную сферу деятельности, отрасль, направление обучения и узнать детали поступления в вуз."
        )
        let programVM1 = ProgramsScreenProgramCellViewModel(programTitle: "Образование и педагогика")
        let programVM2 = ProgramsScreenProgramCellViewModel(programTitle: "Математика, информационные науки и технологии")
        
        view?.applySnapshot(
            sections: [.header, .programs, .footer],
            itemsBySection: [
                .header : [ .headerItem(.init(id: "header", viewModel: headerVM)) ],
                .programs : [
                    .programItem(.init(id: 1, viewModel: programVM1)),
                    .programItem(.init(id: 2, viewModel: programVM2)),
                    .programItem(.init(id: 3, viewModel: programVM1))
                ],
                .footer : [ .footerItem(.init(id: "footer", viewModel: footerVM)) ]
            ]
        )
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
}
