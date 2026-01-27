//
//  UniversityScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import SnapKit

protocol UniversityScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAccount()
}

final class UniversityScreenPresenter {
    weak var view: UniversityScreenViewProtocol?
    var router: UniversityScreenRouterProtocol
    var interactor: UniversityScreenInteractorProtocol

    init(interactor: UniversityScreenInteractorProtocol, router: UniversityScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension UniversityScreenPresenter: UniversityScreenPresenterProtocol {
    func viewDidLoad() {
        var count = 0
        let headerVM = UniversityScreenHeaderCellViewModel()
        let filtersVM = UniversityScreenFilterCellViewModel(didTapFilters: { [weak self] in self?.router.presentFilterView() })
        let pageIndicatorVM = PageIndicatorCellViewModel(totalPages: 4, currentPage: 3)
        let footerVM = TabsFooterCellViewModel(
            titleLabelText: "Список вузов Казахстана по среднему баллу, стоимости обучения",
            subtitleLabelText: "С поступлением теперь легче — с платформой «Поступи Онлайн Казахстан»! Сервис работает на базе рекомендательной системы с искусственным интеллектом, которая анализирует твои интересы и предлагает именно те университеты, которые подходят тебе по направлениям, уровню подготовки и другим параметрам. Все вузы, представленные на платформе, имеют действующую государственную лицензию и прошли аккредитацию по программам высшего образования. На сайте собрана подробная и актуальная информация о государственных и частных вузах Казахстана: университетах, институтах, академиях, расположенных в разных регионах страны — от Алматы и Астаны до Шымкента и Усть-Каменогорска. Ты можешь отсортировать вузы по среднему баллу ЕНТ за 2025 год, чтобы понять, куда у тебя больше шансов поступить. Также доступна статистика прошлых лет: проходные баллы, конкурс, стоимость обучения, количество бюджетных и платных мест. Это поможет тебе оценить свои перспективы и выбрать наиболее подходящий вариант для получения высшего образования. "
        )
        let universities: [ECUniversity] = [.sample, .sample, .sample]
        
        var universityItems: [UniversityScreenItem] = universities.map {
            let vm = UniversityCellViewModel(university: $0, horizontallySpaced: true)
            let item = DiffableItem(id: $0.id + count, viewModel: vm)
            count += 1
            return .universityItem(item)
        }
        
        universityItems.append(UniversityScreenItem.pageIndicatorItem(.init(id: "pageIndicator", viewModel: pageIndicatorVM)))
        
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
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
}
