//
//  LoginScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit
import SnapKit

protocol LoginScreenViewProtocol: AnyObject {
    func configureCollectionView(dataSource: LoginScreenDataSource)
}

final class LoginScreenVC: UIViewController {
    
    // MARK: - PROPERTIES
    var presenter: LoginScreenPresenterProtocol?

    // MARK: - VIEW PROPERTIES
    private var headerView: ECHeaderView = ECHeaderView()
    private lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .vertical
        cvLayout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: cvLayout)
        collectionView.register(cell: LoginScreenRegistrationCell.self)
        collectionView.backgroundColor = .systemBlue
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self.headerHeight)
        }
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.headerHeight)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension LoginScreenVC: LoginScreenViewProtocol {
    func configureCollectionView(dataSource: LoginScreenDataSource) {
        self.collectionView.dataSource = dataSource
        self.collectionView.reloadData()
    }
}

extension LoginScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
