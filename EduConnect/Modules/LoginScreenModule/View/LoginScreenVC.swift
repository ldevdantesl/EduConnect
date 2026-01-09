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
    func scrollToNextCell()
    func scrollBackToPreviousCell()
}

final class LoginScreenVC: UIViewController {
    
    // MARK: - VIPER
    var presenter: LoginScreenPresenterProtocol?

    // MARK: - PROPERTIES
    private var currentIndex: Int = 0

    // MARK: - VIEW PROPERTIES
    private var headerView: ECHeaderView = ECHeaderView()
    private lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: cvLayout)
        collectionView.register(cell: LoginScreenRegistrationCell.self)
        collectionView.register(cell: LoginScreenConfirmRegistrationCell.self)
        collectionView.register(cell: LoginScreenSetPasswordCell.self)
        collectionView.register(cell: LoginScreenCompleteRegistrationCell.self)
        collectionView.backgroundColor = .systemBlue
        collectionView.isScrollEnabled = false
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
    
    func scrollToNextCell() {
        print("Scrolling Next")
        let next = currentIndex + 1
        guard next < collectionView.numberOfItems(inSection: 0) else { return }

        currentIndex = next
        collectionView.scrollToItem(
            at: IndexPath(item: next, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func scrollBackToPreviousCell() {
        print("Scrolling Back")
        let prev = currentIndex - 1
        guard prev >= 0 else { return }

        currentIndex = prev
        collectionView.scrollToItem(
            at: IndexPath(item: prev, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
}

extension LoginScreenVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    
}
