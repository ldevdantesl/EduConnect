//
//  UniversityInfoScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit
import SnapKit

protocol UniversityInfoScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [UniversityInfoScreenSection], itemsBySection: [UniversityInfoScreenSection : [UniversityInfoScreenItem]])
    func reconfigureItems(items: [UniversityInfoScreenItem])
    func showError(errorMessage: String)
}

final class UniversityInfoScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: UniversityInfoScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapAccount() }
        didTapBack: { [weak self] in self?.presenter?.didTapBack() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private let collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<UniversityInfoScreenSection, UniversityInfoScreenItem>(
            layout: UniversityScreenLayoutFactory.make()
        )
        cv.registerCell(UniversityInfoScreenHeaderCell.self, reuseID: UniversityInfoScreenHeaderCell.identifier)
        cv.registerCell(UniversityInfoScreenAverageEntCell.self, reuseID: UniversityInfoScreenAverageEntCell.identifier)
        cv.registerCell(UniversityInfoScreenAboutCell.self, reuseID: UniversityInfoScreenAboutCell.identifier)
        cv.registerCell(UniversityInfoScreenContactsCell.self, reuseID: UniversityInfoScreenContactsCell.identifier)
        cv.registerCell(SectionHeaderCell.self, reuseID: SectionHeaderCell.identifier)
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityInfoScreenHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .averageENTScoreItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityInfoScreenAverageEntCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .aboutItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityInfoScreenAboutCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .contactsItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityInfoScreenContactsCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .sectionHeaderItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? SectionHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension UniversityInfoScreenVC: UniversityInfoScreenViewProtocol {
    func applySnapshot(sections: [UniversityInfoScreenSection], itemsBySection: [UniversityInfoScreenSection : [UniversityInfoScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [UniversityInfoScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func showError(errorMessage: String) {
        self.showError(message: errorMessage) /// Added from Extensions
    }
}
