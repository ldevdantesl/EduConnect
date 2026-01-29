//
//  ProgramsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit
import SnapKit

protocol ProgramsScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ProgramsScreenSection], itemsBySection: [ProgramsScreenSection : [ProgramsScreenItem]])
    func reconfigureItems(items: [ProgramsScreenItem])
    func showError(errorMessage: String)
}

final class ProgramsScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ProgramsScreenPresenterProtocol?
    private let sectionStore = ECDiffableSectionStore<ProgramsScreenSection>()

    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapTabBar() }
        didTapAccount: { [weak self] in self?.presenter?.didTapAccount() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let layout = ProgramsScreenLayoutFactory.make(sectionStore: sectionStore)
        let cv = DiffableCollectionViewContainer<ProgramsScreenSection, ProgramsScreenItem>(layout: layout)
        cv.registerCell(LoadingCell.self, reuseID: LoadingCell.identifier)
        cv.registerCell(ProgramsScreenHeaderCell.self, reuseID: ProgramsScreenHeaderCell.identifier)
        cv.registerCell(TabsFooterCell.self, reuseID: TabsFooterCell.identifier)
        cv.registerCell(ProgramsScreenProgramCell.self, reuseID: ProgramsScreenProgramCell.identifier)
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? ProgramsScreenHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .footerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? TabsFooterCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .programItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? ProgramsScreenProgramCell
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

extension ProgramsScreenVC: ProgramsScreenViewProtocol {
    func applySnapshot(sections: [ProgramsScreenSection], itemsBySection: [ProgramsScreenSection : [ProgramsScreenItem]]) {
        sectionStore.update(sections)
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [ProgramsScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func showError(errorMessage: String) {
        self.showError(message: errorMessage) /// Added from Extensions
    }
}
