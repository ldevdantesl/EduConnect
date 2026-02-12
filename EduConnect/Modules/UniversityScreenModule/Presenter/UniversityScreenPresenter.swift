//
//  UniversityScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

protocol UniversityScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAccount()
    func didTapAppLogo()
    func didGetCities(cities: [ECCity])
    func didGetProfessions(professions: [ECReferenceProfession])
    func didReceiveUniversities(paginatedUniversities: PaginatedResponse<ECUniversity>)
    
    func didReceiveError(error: any Error)
}

final class UniversityScreenPresenter {
    
    // MARK: - VIPER
    weak var view: UniversityScreenViewProtocol?
    var router: UniversityScreenRouterProtocol
    var interactor: UniversityScreenInteractorProtocol
    private let errorService: ErrorServiceProtocol

    // MARK: - PROPERTIES
    private let dispatchGroup = DispatchGroup()
    private lazy var showUniversitiesWorkItem: DispatchWorkItem = .init {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in self?.showUniversities() }
    }
    
    private var currentFilters: UniversityFilters = UniversityFilters()
    private var searchText: String? = nil
    
    private var universities: [ECUniversity] = []
    private var cities: [ECCity] = []
    private var professions: [ECReferenceProfession] = []
    
    private var totalPages: Int = 1
    private var currentPage: Int = 1
    
    private let headerVM = UniversityScreenHeaderCellViewModel()
    private let footerVM = TabsFooterCellViewModel(
        titleLabelText: "Список вузов Казахстана по среднему баллу, стоимости обучения",
        subtitleLabelText: "С поступлением теперь легче — с платформой «Поступи Онлайн Казахстан»! Сервис работает на базе рекомендательной системы с искусственным интеллектом, которая анализирует твои интересы и предлагает именно те университеты, которые подходят тебе по направлениям, уровню подготовки и другим параметрам. Все вузы, представленные на платформе, имеют действующую государственную лицензию и прошли аккредитацию по программам высшего образования. На сайте собрана подробная и актуальная информация о государственных и частных вузах Казахстана: университетах, институтах, академиях, расположенных в разных регионах страны — от Алматы и Астаны до Шымкента и Усть-Каменогорска. Ты можешь отсортировать вузы по среднему баллу ЕНТ за 2025 год, чтобы понять, куда у тебя больше шансов поступить. Также доступна статистика прошлых лет: проходные баллы, конкурс, стоимость обучения, количество бюджетных и платных мест. Это поможет тебе оценить свои перспективы и выбрать наиболее подходящий вариант для получения высшего образования. "
    )
   
    init(interactor: UniversityScreenInteractorProtocol, router: UniversityScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    // MARK: - PRIVATE FUNC
    private func showInitialView() {
        let loadingVM = LoadingCellViewModel()
        view?.applySnapshot(
            sections: [.header, .footer],
            itemsBySection: [
                .header: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .loadingItem(.init(viewModel: loadingVM))
                ],
                .footer: [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }

    private func showLoading() {
        let filterVM = UniversityScreenFilterCellViewModel(
            currentFilters: currentFilters,
            searchText: searchText,
            didTapSearch: { [weak self] in self?.search(text: $0) },
            didTapFilters: { [weak self] in self?.openFilters() }
        )
        
        view?.applySnapshot(
            sections: [.header, .universities, .footer],
            itemsBySection: [
                .header: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .filterItem(.init(viewModel: filterVM))
                ],
                .universities: [
                    .loadingItem(.init(viewModel: LoadingCellViewModel()))
                ],
                .footer: [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }

    private func showUniversities() {
        let filterVM = UniversityScreenFilterCellViewModel(
            currentFilters: currentFilters,
            searchText: searchText,
            didTapSearch: { [weak self] in self?.search(text: $0) },
            didTapFilters: { [weak self] in self?.openFilters() }
        )
        
        var universityItems = universities.map {
            let vm = UniversityCellViewModel(university: $0, horizontallySpaced: true) { [weak self] in
                guard let self = self else { return }
                self.router.routeToUniversityInfo($0)
            }
            return UniversityScreenItem.universityItem(.init(viewModel: vm))
        }
        
        if totalPages > 1 {
            let pageIndicatorVM = PageIndicatorCellViewModel(
                totalPages: totalPages,
                currentPage: currentPage,
                didPressNextPage: { [weak self] in self?.goToPage((self?.currentPage ?? 1) + 1) },
                didPressPage: { [weak self] in self?.goToPage($0) }
            )
            universityItems.append(.pageIndicatorItem(.init(viewModel: pageIndicatorVM)))
        }
        
        view?.applySnapshot(
            sections: [.header, .universities, .footer],
            itemsBySection: [
                .header: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .filterItem(.init(viewModel: filterVM))
                ],
                .universities: universityItems,
                .footer: [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }

    // MARK: - ACTIONS
    private func fetchUniversities() {
        showLoading()
        dispatchGroup.enter()
        interactor.getUniversities(page: currentPage, searchKey: searchText, filters: currentFilters)
        dispatchGroup.notify(queue: .main, work: showUniversitiesWorkItem)
    }

    private func search(text: String) {
        searchText = text
        currentPage = 1
        fetchUniversities()
    }

    private func openFilters() {
        router.presentFilterView(
            currentFilters: currentFilters,
            cities: cities,
            professions: professions,
            onApply: { [weak self] filters in
                self?.currentFilters = filters
                self?.currentPage = 1
                self?.fetchUniversities()
            }
        )
    }

    private func goToPage(_ page: Int) {
        currentPage = page
        view?.scrollToTop { [weak self] in
            self?.fetchUniversities()
        }
    }
}

extension UniversityScreenPresenter: UniversityScreenPresenterProtocol {
    func viewDidLoad() {
        showInitialView()
        
        dispatchGroup.enter()
        interactor.getUniversities(page: 1, searchKey: nil, filters: nil)
        
        dispatchGroup.enter()
        interactor.getAllCities()
        
        dispatchGroup.enter()
        interactor.getAllProfessions()

        dispatchGroup.notify(queue: .main, work: showUniversitiesWorkItem)
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
    
    func didGetCities(cities: [ECCity]) {
        self.cities = cities
        dispatchGroup.leave()
    }
    
    func didGetProfessions(professions: [ECReferenceProfession]) {
        self.professions = professions
        dispatchGroup.leave()
    }
    
    func didReceiveUniversities(paginatedUniversities: PaginatedResponse<ECUniversity>) {
        self.universities = paginatedUniversities.data
        self.totalPages = paginatedUniversities.meta.total
        self.currentPage = paginatedUniversities.meta.currentPage
        dispatchGroup.leave()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        view?.showError(errorMessage: userError.message)
        dispatchGroup.leave()
    }
}
