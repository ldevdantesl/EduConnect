//
//  ProfessionsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

import UIKit
import SnapKit

protocol ProfessionsScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ProfessionScreenSection], itemsBySection: [ProfessionScreenSection : [ProfessionScreenItem]])
    func showError(errorMessage: String)
}

final class ProfessionsScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ProfessionsScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapAccount() }
        didTapImage: { [weak self] in self?.presenter?.didTapAppLogo() }
        didTapBar: { [weak self] in self?.presenter?.didTapTabBar() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private let collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<ProfessionScreenSection, ProfessionScreenItem>(
            layout: ProfessionScreenLayoutFactory.make()
        )
        cv.registerCell(ProfessionScreenHeaderCell.self, reuseID: ProfessionScreenHeaderCell.identifier)
        cv.registerCell(ProfessionScreenSearchCell.self, reuseID: ProfessionScreenSearchCell.identifier)
        cv.registerCell(PageIndicatorCell.self, reuseID: PageIndicatorCell.identifier)
        cv.registerCell(TabsFooterCell.self, reuseID: TabsFooterCell.identifier)
        cv.registerCell(CardWithImageCell.self, reuseID: CardWithImageCell.identifier)
        cv.registerCell(LoadingCell.self, reuseID: LoadingCell.identifier)
        cv.resignsFirstResponderOnScroll = true
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        presenter?.viewDidLoad()
    }
    
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? ProfessionScreenHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .cardWithImageItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? CardWithImageCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .searchItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? ProfessionScreenSearchCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .loadingItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? LoadingCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .pageIndicatorItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? PageIndicatorCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .footerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? TabsFooterCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension ProfessionsScreenVC: ProfessionsScreenViewProtocol {
    func applySnapshot(sections: [ProfessionScreenSection], itemsBySection: [ProfessionScreenSection : [ProfessionScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func showError(errorMessage: String) {
        self.showError(message: errorMessage) /// Added from Extensions
    }
}
