//
//  ProfessionsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

protocol ProfessionsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAccount()
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
    private var currentSearchText: String? = ""
    private var sortOption: ProfessionSortOption?

    init(interactor: ProfessionsScreenInteractorProtocol, router: ProfessionsScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        let headerVM = ProfessionScreenHeaderCellViewModel()
        let searchVM = ProfessionScreenSearchCellViewModel(
            didTapSearch: { [weak self] in self?.didTapSearch(searchText: $0) },
            didTapSortOption: { [weak self] in self?.didTapSortOption(option: $0) }
        )
        let footerVM = TabsFooterCellViewModel(
            titleLabelText: "Выбор профессии в справочнике",
            subtitleLabelText: """
            С поступлением теперь легче — с платформой «Поступи Онлайн Казахстан»! Сервис работает на базе рекомендательной системы с искусственным интеллектом, которая анализирует твои интересы и предлагает именно те университеты, которые подходят тебе по направлениям, уровню подготовки и другим параметрам. Все вузы, представленные на платформе, имеют действующую государственную лицензию и прошли аккредитацию по программам высшего образования. На сайте собрана подробная и актуальная информация о государственных и частных вузах Казахстана: университетах, институтах, академиях, расположенных в разных регионах страны — от Алматы и Астаны до Шымкента и Усть-Каменогорска. Ты можешь отсортировать вузы по среднему баллу ЕНТ за 2025 год, чтобы понять, куда у тебя больше шансов поступить. Также доступна статистика прошлых лет: проходные баллы, конкурс, стоимость обучения, количество бюджетных и платных мест. Это поможет тебе оценить свои перспективы и выбрать наиболее подходящий вариант для получения высшего образования.  Если ты хочешь сфокусироваться на каком-то конкретном вузе, используй удобную функцию
            """
        )
        
        var professionItems: [ProfessionScreenItem] = []
        if !professions.isEmpty {
            professionItems = professions.map { profession in
                let vm = CardCellViewModel(
                    preTitle: "\(profession.programsCount) программ, \(profession.universitiesCount) вузов",
                    title: profession.name.toCurrentLanguage(), subtitle: profession.description.toCurrentLanguage(), showsArrowRight: true
                ) { [weak self] in self?.router.routeToProfession(professionID: profession.id) }
                return ProfessionScreenItem.cardItem(.init(id: profession.id, viewModel: vm))
            }
        } else {
            let notFoundItem = NotFoundCellViewModel(
                systemImage: ImageConstants.SystemImages.questionMark.rawValue,
                title: "Ничего не найдено", subtitle: "Попробуйте еще раз", horizontallySpaced: true
            )
            professionItems = [ProfessionScreenItem.notFoundItem(.init(viewModel: notFoundItem))]
        }
        
        if totalPages > 1 {
            let vm = PageIndicatorCellViewModel(totalPages: totalPages, currentPage: currentPage) { [weak self] in
                guard let self = self else { return }
                self.showPage(self.currentPage+1)
            } didPressPage: { [weak self] in
                self?.showPage($0)
            }
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
        let searchVM = ProfessionScreenSearchCellViewModel(
            didTapSearch: { [weak self] in self?.didTapSearch(searchText: $0) },
            didTapSortOption: { [weak self] in self?.didTapSortOption(option: $0) }
        )
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
        self.currentSearchText = searchText
        applyLoadingSnapshot()
        interactor.getProfessions(searchText: searchText, sortOption: sortOption, page: 1)
    }
    
    private func didTapSortOption(option: ProfessionSortOption?) {
        self.sortOption = option
        applyLoadingSnapshot()
        interactor.getProfessions(searchText: currentSearchText, sortOption: sortOption, page: currentPage)
    }
    
    private func showPage(_ page: Int) {
        applyLoadingSnapshot()
        interactor.getProfessions(searchText: currentSearchText, sortOption: sortOption, page: page)
    }
}

extension ProfessionsScreenPresenter: ProfessionsScreenPresenterProtocol {
    func viewDidLoad() {
        applyLoadingSnapshot()
        interactor.getProfessions(searchText: nil, sortOption: nil, page: 1)
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
