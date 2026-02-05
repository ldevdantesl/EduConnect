//
//  ECHeader.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 3.01.2026.
//

import UIKit
import SnapKit

struct ECHeaderViewModel {
    var didTapBar: (() -> Void)?
    var didTapAccount: (() -> Void)?
    var didTapImage: (() -> Void)?
    var didTapBack: (() -> Void)?
    var showsBackInsteadOfBar: Bool
    
    init(didTapAccount: (() -> Void)? = nil, didTapImage: (() -> Void)? = nil, didTapBar: (() -> Void)?) {
        self.didTapBar = didTapBar
        self.didTapAccount = didTapAccount
        self.didTapBack = nil
        self.showsBackInsteadOfBar = false
    }
    
    init(didTapAccount: (() -> Void)? = nil, didTapImage: (() -> Void)? = nil, didTapBack: (() -> Void)?) {
        self.didTapBack = didTapBack
        self.didTapAccount = didTapAccount
        self.didTapBar = nil
        self.showsBackInsteadOfBar = true
    }
}

final class ECHeaderView: UIView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let logoImageW = 80.0
        static let logoImageH = 44.0
        
        static let vSpacing = 10.0
        static let hSpacing = 10.0
        
        static let backButtonImage = "chevron.left"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ECHeaderViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let accountButton: ECIconButton = {
        let vm = ECIconButtonVM(
            iconName: ImageConstants.accountIcon.rawValue,
            style: .title3, weight: .bold
        )
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let barButton: ECIconButton = {
        let vm = ECIconButtonVM(
            iconName: ImageConstants.tabBarIcon.rawValue,
            style: .title3, weight: .bold
        )
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let backButton: ECIconButton = {
        let vm = ECIconButtonVM(
            systemImage: Constants.backButtonImage,
            color: .black, style: .headline, weight: .medium
        )
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: ImageConstants.appLogo.rawValue)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImage)))
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
    
    public func configure(vm: ECHeaderViewModel) {
        self.viewModel = vm
        
        self.barButton.setAction { [weak self] in self?.viewModel?.didTapBar?() }
        
        self.backButton.setAction { [weak self] in self?.viewModel?.didTapBack?() }
        
        self.accountButton.setAction { [weak self] in self?.viewModel?.didTapAccount?() }
        
        barButton.isHidden = vm.showsBackInsteadOfBar ? true : false
        backButton.isHidden = vm.showsBackInsteadOfBar ? false : true
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
            $0.width.equalTo(Constants.logoImageW)
            $0.height.equalTo(Constants.logoImageH)
        }
        
        self.addSubview(barButton)
        barButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
            $0.leading.equalToSuperview().offset(Constants.hSpacing)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
            $0.leading.equalToSuperview().offset(Constants.hSpacing)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapImage() {
        self.viewModel?.didTapImage?()
    }
}
