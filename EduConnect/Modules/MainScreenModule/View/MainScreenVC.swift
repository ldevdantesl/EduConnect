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
            layout: UniversityScreenLayoutFactory.make()
        )
        cv.registerCell(MainScreenProgramsCell.self, reuseID: MainScreenProgramsCell.identifier)
        cv.registerCell(MainScreenHeaderCell.self, reuseID: MainScreenHeaderCell.identifier)
        cv.registerCell(MainScreenCareersCell.self, reuseID: MainScreenCareersCell.identifier)
        cv.registerCell(MainScreenAcademicCell.self, reuseID: MainScreenAcademicCell.identifier)
        cv.registerCell(MainScreenAcademicProgramCell.self, reuseID: MainScreenAcademicProgramCell.identifier)
        cv.registerCell(MainScreenAcademicShowAllCell.self, reuseID: MainScreenAcademicShowAllCell.identifier)
        cv.registerCell(CardWithImageCell.self, reuseID: CardWithImageCell.identifier)
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
                
            case .academicProfession(let item), .academicUniversity(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? CardWithImageCell
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
            default:
                return UICollectionViewCell()
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
        self.showError(message: errorMessage) /// Added from Extensions
    }
}
