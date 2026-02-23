//
//  HomeScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit
import SnapKit

protocol AccountScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [AccountScreenSection], itemsBySection: [AccountScreenSection : [AccountScreenItem]])
    func reconfigureItems(items: [AccountScreenItem])
    func reloadSection(section: AccountScreenSection)
    
    func showPopup(_ popUp: PopUpView)
    func dismissPopup()
    
    func showError(error: UserFacingError)
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
}

final class AccountScreenVC: UIViewController {
    
    // MARK: - VIPER
    var presenter: AccountScreenPresenterProtocol?
    
    // MARK: - PROPERTIES
    private var popUpView: PopUpView?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel(
            didTapImage: {[weak self] in self?.presenter?.didTapAppLogo() },
            didTapBar: { [weak self] in self?.presenter?.didTapTabBar() }
        )
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<AccountScreenSection, AccountScreenItem>(
            layout: AccountLayoutFactory.make()
        )
        cv.adjustsForKeyboard = true
        cv.resignsFirstResponderOnScroll = true
        cv.registerCell(ApplicationCell.self, reuseID: ApplicationCell.identifier)
        cv.registerCell(NotFoundCell.self, reuseID: NotFoundCell.identifier)
        cv.registerCell(SectionHeaderCell.self, reuseID: SectionHeaderCell.identifier)
        cv.registerCell(AccountScreenExpandablePersonalInfoCell.self, reuseID: AccountScreenExpandablePersonalInfoCell.identifier)
        cv.registerCell(AccountScreenExpandableFamilyInfoCell.self, reuseID: AccountScreenExpandableFamilyInfoCell.identifier)
        cv.registerCell(AccountScreenExpandableEducationCell.self, reuseID: AccountScreenExpandableEducationCell.identifier)
        cv.registerCell(AccountScreenExpandableENTCell.self, reuseID: AccountScreenExpandableENTCell.identifier)
        cv.registerCell(AccountScreenExpandableOlympiadCell.self, reuseID: AccountScreenExpandableOlympiadCell.identifier)
        cv.registerCell(AccountScreenExpandableExtracurricularCell.self, reuseID: AccountScreenExpandableExtracurricularCell.identifier)
        cv.registerCell(AccountScreenMainTabInfoCell.self, reuseID: AccountScreenMainTabInfoCell.identifier)
        cv.registerSupplementary(
            AccountScreenSegmentedReusableMenu.self,
            kind: UICollectionView.elementKindSectionHeader,
            reuseID: AccountScreenSegmentedReusableMenu.reuseID
        )
        return cv
    }()

    // MARK: - LIFE CYCLE
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? SectionHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .university(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? ApplicationCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .expandableCell(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath)
                (cell as? ConfigurableCellProtocol)?.configure(withVM: item.viewModel)
                return cell
            case .notFoundItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath)
                (cell as? ConfigurableCellProtocol)?.configure(withVM: item.viewModel)
                return cell
            case .mainTabInfo(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? AccountScreenMainTabInfoCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
        
        collectionContainer.setSupplementaryViewProvider { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return nil }
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AccountScreenSegmentedReusableMenu.reuseID,
                for: indexPath
            ) as? AccountScreenSegmentedReusableMenu else { return nil }
            guard let vm = self.presenter?.headerMenuViewModel else { return header }
            header.configure(withVM: vm)
            return header
        }
    }
}

extension AccountScreenVC: AccountScreenViewProtocol {
    func applySnapshot(sections: [AccountScreenSection], itemsBySection: [AccountScreenSection : [AccountScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [AccountScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func reloadSection(section: AccountScreenSection) {
        collectionContainer.reloadSection(section: section)
    }
    
    func showPopup(_ popUp: PopUpView) {
        self.popUpView = popUp
        popUp.show(in: view)
    }
    
    func dismissPopup() {
        popUpView?.dismiss()
        self.popUpView = nil
    }
    
    func showError(error: UserFacingError) {
        self.showToastedError(userError: error)
    }
    
    func showMessage(message: String) {
        self.showToastedMessage(message: message)
    }
    
    func showLoading() {
        self.showHoverLoading()
    }
    
    func hideLoading() {
        self.hideHoverLoading()
    }
}
