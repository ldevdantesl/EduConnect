//
//  UniversityScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit
import SnapKit

protocol UniversityScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [UniversityScreenSection], itemsBySection: [UniversityScreenSection : [UniversityScreenItem]])
    func reconfigureItems(items: [UniversityScreenItem])
    func showError(errorMessage: String)
}

final class UniversityScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: UniversityScreenPresenterProtocol?

    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapTabBar() }
        didTapAccount: { [weak self] in self?.presenter?.didTapAccount() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private let collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<UniversityScreenSection, UniversityScreenItem>(
            layout: UniversityScreenLayoutFactory.make()
        )
        cv.registerCell(LoadingCell.self, reuseID: LoadingCell.identifier)
        cv.registerCell(UniversityScreenHeaderCell.self, reuseID: UniversityScreenHeaderCell.identifier)
        cv.registerCell(UniversityScreenFilterCell.self, reuseID: UniversityScreenFilterCell.identifier)
        cv.registerCell(UniversityCell.self, reuseID: UniversityCell.identifier)
        cv.registerCell(PageIndicatorCell.self, reuseID: PageIndicatorCell.identifier)
        cv.registerCell(TabsFooterCell.self, reuseID: TabsFooterCell.identifier)
        cv.backgroundColor = .clear
        cv.resignsFirstResponderOnScroll = true
        return cv
    }()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self.headerHeight)
        }
        
        self.view.addSubview(collectionContainer)
        collectionContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.headerHeight)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        collectionContainer.configureDataSource { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .headerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityScreenHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .filterItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityScreenFilterCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .pageIndicatorItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? PageIndicatorCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .universityItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .footerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? TabsFooterCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .loadingItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? LoadingCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension UniversityScreenVC: UniversityScreenViewProtocol {
    func applySnapshot(sections: [UniversityScreenSection], itemsBySection: [UniversityScreenSection : [UniversityScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [UniversityScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func showError(errorMessage: String) {
        self.showError(message: errorMessage) /// Added from Extensions
    }
}
