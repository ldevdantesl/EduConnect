//
//  HomeScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit
import SnapKit

protocol HomeScreenViewProtocol: AnyObject { }

final class HomeScreenVC: UIViewController {
    
    // MARK: - VIPER
    var presenter: HomeScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private let headerView = ECHeaderView()
    
    private lazy var collectionContainer =
        DiffableCollectionViewContainer<HomeSection, HomeItem>(
            layout: HomeLayoutFactory.make()
        )

    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
}

extension HomeScreenVC: HomeScreenViewProtocol {
    
}
