//
//  MainScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

import UIKit
import SnapKit

protocol MainScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [MainScreenSection], itemsBySection: [MainScreenSection : [MainScreenItem]])
    func reconfigureItems(items: [MainScreenItem])
    func showError(errorMessage: String)
    func showLoading()
    func hideLoading()
    func scrollToSection(section: MainScreenSection, onCompletion: (() -> Void)?)
}

final class MainScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: MainScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapAccount() }
        didTapBar: { [weak self] in self?.presenter?.didTapTabBar() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private let collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<MainScreenSection, MainScreenItem>(
            layout: MainScreenLayoutFactory.make()
        )
        cv.registerCell(MainScreenProgramsCell.self, reuseID: MainScreenProgramsCell.identifier)
        cv.registerCell(MainScreenHeaderCell.self, reuseID: MainScreenHeaderCell.identifier)
        cv.registerCell(MainScreenStepsCell.self, reuseID: MainScreenStepsCell.identifier)
        cv.registerCell(MainScreenCareersCell.self, reuseID: MainScreenCareersCell.identifier)
        cv.registerCell(MainScreenAcademicCell.self, reuseID: MainScreenAcademicCell.identifier)
        cv.registerCell(MainScreenAcademicProgramCell.self, reuseID: MainScreenAcademicProgramCell.identifier)
        cv.registerCell(MainScreenAcademicShowAllCell.self, reuseID: MainScreenAcademicShowAllCell.identifier)
        cv.registerCell(MainScreenServicesCell.self, reuseID: MainScreenServicesCell.identifier)
        cv.registerCell(MainScreenJournalCell.self, reuseID: MainScreenJournalCell.identifier)
        cv.registerCell(MainScreenFooterCell.self, reuseID: MainScreenFooterCell.identifier)
        cv.registerCell(UnderlineButtonCell.self, reuseID: UnderlineButtonCell.identifier)
        cv.registerCell(CardWithImageCell.self, reuseID: CardWithImageCell.identifier)
        cv.registerCell(LoadingCell.self, reuseID: LoadingCell.identifier)
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .careersItem(let item) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenCareersCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .programItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenProgramsCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .academicItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenAcademicCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .academicProgram(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenAcademicProgramCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .academicShowAll(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenAcademicShowAllCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .stepsItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenStepsCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .servicesItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenServicesCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .journalItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenJournalCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .cardWithImageItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? CardWithImageCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .loadingItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? LoadingCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .footerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? MainScreenFooterCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .underlineButtonItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UnderlineButtonCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension MainScreenVC: MainScreenViewProtocol {
    func applySnapshot(sections: [MainScreenSection], itemsBySection: [MainScreenSection : [MainScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [MainScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func showError(errorMessage: String) {
        self.showToastedError(message: errorMessage) /// Added from Extensions
    }
    
    func showLoading() {
        self.showHoverLoading()
    }
    
    func hideLoading() {
        self.hideHoverLoading()
    }
    
    func scrollToSection(section: MainScreenSection, onCompletion: (() -> Void)?) {
        self.collectionContainer.scrollToSection(section, onCompletion: onCompletion)
    }
}
