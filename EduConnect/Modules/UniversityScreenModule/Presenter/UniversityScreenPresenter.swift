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
    private var universities: [ECUniversity] = []
    private let headerVM = UniversityScreenHeaderCellViewModel()
    private lazy var filtersVM = UniversityScreenFilterCellViewModel(didTapFilters: { [weak self] in self?.router.presentFilterView() })
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
                    .filterItem(.init(id: "filter", viewModel: filtersVM)),
                    .loadingItem(.init(viewModel: loadingVM))
                ],
                .footer : [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }
    
    private func showUniversities() {
        let pageIndicatorVM = PageIndicatorCellViewModel(totalPages: 4, currentPage: 3)
        var universityItems = universities.map {
            UniversityScreenItem.universityItem(.init(viewModel: .init(university: $0, horizontallySpaced: true)))
        }
        universityItems.append(.pageIndicatorItem(.init(viewModel: pageIndicatorVM)))
        view?.applySnapshot(
            sections: [.header, .universities, .footer],
            itemsBySection: [
                .header: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .filterItem(.init(id: "filter", viewModel: filtersVM))
                ],
                .universities : universityItems,
                .footer : [.footerItem(.init(id: "footer", viewModel: footerVM))]
            ]
        )
    }
}

extension UniversityScreenPresenter: UniversityScreenPresenterProtocol {
    func viewDidLoad() {
        showInitialView()
        interactor.getUniversities(page: 1, searchKey: nil, filters: nil)
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    
    func didReceiveUniversities(paginatedUniversities: PaginatedResponse<ECUniversity>) {
        self.universities = paginatedUniversities.data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in self?.showUniversities() }
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        view?.showError(errorMessage: userError.message)
    }
}
