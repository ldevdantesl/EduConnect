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
    
    // MARK: - FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBlue
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self.headerHeight)
        }
    }
}

extension LoginScreenVC: LoginScreenViewProtocol { }
