//
//  HomeScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit
import SnapKit

protocol HomeScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [HomeScreenSection], itemsBySection: [HomeScreenSection : [HomeScreenItem]])
    func reconfigureItems(items: [HomeScreenItem])
    func showPopup(_ popUp: PopUpView)
    func dismissPopup()
}

final class HomeScreenVC: UIViewController {
    
    // MARK: - VIPER
    var presenter: HomeScreenPresenterProtocol?
    
    // MARK: - PROPERTIES
    private var popUpView: PopUpView?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapTabBar() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<HomeScreenSection, HomeScreenItem>(
            layout: HomeLayoutFactory.make()
        )
        cv.resignsFirstResponderOnScroll = true
        cv.registerCell(UniversityCell.self, reuseID: UniversityCell.identifier)
        cv.registerCell(SectionHeaderCell.self, reuseID: SectionHeaderCell.identifier)
        cv.registerCell(HomeScreenExpandablePersonalInfoCell.self, reuseID: HomeScreenExpandablePersonalInfoCell.identifier)
        cv.registerCell(HomeScreenExpandableFamilyInfoCell.self, reuseID: HomeScreenExpandableFamilyInfoCell.identifier)
        cv.registerCell(HomeScreenExpandableEducationCell.self, reuseID: HomeScreenExpandableEducationCell.identifier)
        cv.registerCell(HomeScreenExpandableENTCell.self, reuseID: HomeScreenExpandableENTCell.identifier)
        cv.registerCell(HomeScreenExpandableOlympiadCell.self, reuseID: HomeScreenExpandableOlympiadCell.identifier)
        cv.registerCell(HomeScreenExpandableExtracurricularCell.self, reuseID: HomeScreenExpandableExtracurricularCell.identifier)
        cv.registerCell(HomeScreenMainTabInfoCell.self, reuseID: HomeScreenMainTabInfoCell.identifier)
        cv.registerSupplementary(
            HomeScreenSegmentedReusableMenu.self,
            kind: UICollectionView.elementKindSectionHeader,
            reuseID: HomeScreenSegmentedReusableMenu.reuseID
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .expandableCell(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath)
                (cell as? ConfigurableCellProtocol)?.configure(withVM: item.viewModel)
                return cell
            case .mainScreenInfo(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? HomeScreenMainTabInfoCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
        
        collectionContainer.setSupplementaryViewProvider { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return nil }
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeScreenSegmentedReusableMenu.reuseID,
                for: indexPath
            ) as? HomeScreenSegmentedReusableMenu else { return nil }
            guard let vm = self.presenter?.headerMenuViewModel else { return header }
            header.configure(withVM: vm)
            return header
        }
    }
}

extension HomeScreenVC: HomeScreenViewProtocol {
    func applySnapshot(sections: [HomeScreenSection], itemsBySection: [HomeScreenSection : [HomeScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [HomeScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func showPopup(_ popUp: PopUpView) {
        self.popUpView = popUp
        popUp.show(in: view)
    }
    
    func dismissPopup() {
        self.popUpView = nil
    }
}
