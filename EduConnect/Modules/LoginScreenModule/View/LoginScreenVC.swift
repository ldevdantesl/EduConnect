//
//  LoginScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit
import SnapKit

protocol LoginScreenViewProtocol: AnyObject { }

final class LoginScreenVC: UIViewController {
    
    // MARK: - PROPERTIES
    var presenter: LoginScreenPresenterProtocol?

    // MARK: - VIEW PROPERTIES
    private var headerView: ECHeaderView = ECHeaderView()
    private let collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .vertical
        cvLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: cvLayout)
        collectionView.register(cell: LoginScreenRegistrationCell.self)
        collectionView.backgroundColor = .systemBlue
        return collectionView
    }()
    
    // MARK: - FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
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
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
}

extension LoginScreenVC: LoginScreenViewProtocol { }
