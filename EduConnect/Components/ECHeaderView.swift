//
//  ECHeader.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 3.01.2026.
//

import UIKit
import SnapKit

final class ECHeaderView: UIView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // AccountButton
        static let accountButtonImageName = ImageConstants.accountIconImage
        
        // BarButton
        static let barButtonImageName = ImageConstants.tabBarIconImage
        
        // App Logo Image
        static let logoImageW = 74.0
        static let logoImageH = 44
        
        // Spacing
        static let vSpacing = 10.0
        static let hSpacing = 10.0
    }
    
    // MARK: - VIEW PROPERTIES
    private let accountButton: ECIconButton = {
        let vm = ECIconButtonVM(
            iconName: Constants.accountButtonImageName,
            style: .title3, weight: .bold
        ) {
            print("Tapped Account Button")
        }
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let barButton: ECIconButton = {
        let vm = ECIconButtonVM(
            iconName: Constants.barButtonImageName,
            style: .title3, weight: .bold
        ) {
            print("Tapped Bar Button")
        }
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: ImageConstants.appLogo)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(accountButton)
        accountButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.hSpacing)
        }
        
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(snp.topMargin)
        }
        
        self.addSubview(barButton)
        barButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
            $0.leading.equalToSuperview().offset(Constants.hSpacing)
        }
        
    }
}
