//
//  ProfessionsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

protocol ProfessionsScreenPresenterProtocol: AnyObject {
    func didTapTabBar()
    func didTapAccount()
    func viewDidLoad()
    func didTapAppLogo()
    
    func didReceiveError(error: any Error)
    func didReceiveProfessions(_ professions: [ECProfession], currentPage: Int, totalPages: Int)
}

final class ProfessionsScreenPresenter {
    weak var view: ProfessionsScreenViewProtocol?
    var router: ProfessionsScreenRouterProtocol
    var interactor: ProfessionsScreenInteractorProtocol
    
    private let errorService: ErrorServiceProtocol
    
    private var professions: [ECProfession] = []
    private var totalPages: Int = 1
    private var currentPage: Int = 1

    init(interactor: ProfessionsScreenInteractorProtocol, router: ProfessionsScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        let headerVM = ProfessionScreenHeaderCellViewModel()
        let searchVM = ProfessionScreenSearchCellViewModel(didTapSearch: { [weak self] in
            print("Search text: \($0)")
            self?.didTapSearch(searchText: $0)
        })
        let footerVM = TabsFooterCellViewModel(
            titleLabelText: "Выбор профессии в справочнике",
            subtitleLabelText: """
            С поступлением теперь легче — с платформой «Поступи Онлайн Казахстан»! Сервис работает на базе рекомендательной системы с искусственным интеллектом, которая анализирует твои интересы и предлагает именно те университеты, которые подходят тебе по направлениям, уровню подготовки и другим параметрам. Все вузы, представленные на платформе, имеют действующую государственную лицензию и прошли аккредитацию по программам высшего образования. На сайте собрана подробная и актуальная информация о государственных и частных вузах Казахстана: университетах, институтах, академиях, расположенных в разных регионах страны — от Алматы и Астаны до Шымкента и Усть-Каменогорска. Ты можешь отсортировать вузы по среднему баллу ЕНТ за 2025 год, чтобы понять, куда у тебя больше шансов поступить. Также доступна статистика прошлых лет: проходные баллы, конкурс, стоимость обучения, количество бюджетных и платных мест. Это поможет тебе оценить свои перспективы и выбрать наиболее подходящий вариант для получения высшего образования.  Если ты хочешь сфокусироваться на каком-то конкретном вузе, используй удобную функцию
            """
        )
        
        var professionItems: [ProfessionScreenItem] = professions.map {
            let vm = CardWithImageCellViewModel(
                imageURL: $0.imageURL,
                preTitle: "\($0.programsCount) программ, \($0.universitiesCount) вузов",
                title: $0.name.ru,
                subtitle: $0.description.ru,
                showsArrowRight: false
            )
            return ProfessionScreenItem.cardWithImageItem(.init(id: $0.id, viewModel: vm))
        }
        
        if totalPages > 1 {
            let vm = PageIndicatorCellViewModel(totalPages: totalPages, currentPage: currentPage)
            professionItems.append(.pageIndicatorItem(.init(viewModel: vm)))
        }
        
        view?.applySnapshot(
            sections: [.header, .search, .main, .footer],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .search : [.searchItem(.init(id: "search", viewModel: searchVM))],
                .main : professionItems,
                .footer : [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }
    
    private func applyLoadingSnapshot() {
        let headerVM = ProfessionScreenHeaderCellViewModel()
        let searchVM = ProfessionScreenSearchCellViewModel(didTapSearch: { [weak self] in self?.didTapSearch(searchText: $0)})
        let footerVM = TabsFooterCellViewModel(
            titleLabelText: "Выбор профессии в справочнике",
            subtitleLabelText: """
            С поступлением теперь легче — с платформой «Поступи Онлайн Казахстан»! Сервис работает на базе рекомендательной системы с искусственным интеллектом, которая анализирует твои интересы и предлагает именно те университеты, которые подходят тебе по направлениям, уровню подготовки и другим параметрам. Все вузы, представленные на платформе, имеют действующую государственную лицензию и прошли аккредитацию по программам высшего образования. На сайте собрана подробная и актуальная информация о государственных и частных вузах Казахстана: университетах, институтах, академиях, расположенных в разных регионах страны — от Алматы и Астаны до Шымкента и Усть-Каменогорска. Ты можешь отсортировать вузы по среднему баллу ЕНТ за 2025 год, чтобы понять, куда у тебя больше шансов поступить. Также доступна статистика прошлых лет: проходные баллы, конкурс, стоимость обучения, количество бюджетных и платных мест. Это поможет тебе оценить свои перспективы и выбрать наиболее подходящий вариант для получения высшего образования.  Если ты хочешь сфокусироваться на каком-то конкретном вузе, используй удобную функцию
            """
        )
        let loadingVM = LoadingCellViewModel()
        
        view?.applySnapshot(
            sections: [.header, .search, .main, .footer],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .search : [.searchItem(.init(id: "search", viewModel: searchVM))],
                .main :   [.loadingItem(.init(viewModel: loadingVM))],
                .footer : [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }
    
    private func didTapSearch(searchText: String) {
        applyLoadingSnapshot()
        interactor.getProfessions(searchText: searchText)
    }
}

extension ProfessionsScreenPresenter: ProfessionsScreenPresenterProtocol {
    func viewDidLoad() {
        applyLoadingSnapshot()
        interactor.getProfessions(searchText: nil)
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
    
    func didReceiveProfessions(_ professions: [ECProfession], currentPage: Int, totalPages: Int) {
        print("📄 professions: \(professions.count), currentPage: \(currentPage), totalPages: \(totalPages)")
        self.professions = professions
        self.currentPage = currentPage
        self.totalPages = totalPages
        applySnapshot()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(errorMessage: userError.message)
    }
}
