//
//  LoginScreenCompleteRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenCompleteRegistrationCellVM {
    let goToAccountAction: (() -> Void)?
    let goToMainAction: (() -> Void)?
    
    init(goToAccountAction: (() -> Void)? = nil, goToMainAction: (() -> Void)? = nil) {
        self.goToAccountAction = goToAccountAction
        self.goToMainAction = goToMainAction
    }
}

final class LoginScreenCompleteRegistrationCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Spacing
        static let hSpacing = 15.0
        static let verticalStackSpacing = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenCompleteRegistrationCellVM?
    
    // MARK: - VIEW PROPERTIES
    private let signInCompletedTitle: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page4.signInCompletedTitle
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let signInCompletedSubtitle: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page4.signInCompletedSubtitle
        label.font = ECFont.font(.bold, size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let goToAccountButton: ECButton = ECButton(text: ConstantLocalizedStrings.Registration.Page4.goToAccountButton)
    private let goToMainButton: ECButton = ECButton(text: ConstantLocalizedStrings.Registration.Page4.goToMainButton)
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 0
        stack.isUserInteractionEnabled = true
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: Constants.hSpacing, bottom: 0, right: Constants.hSpacing)
        return stack
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vStack.layer.cornerRadius = SharedConstants.standardCornerRadius
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: LoginScreenCompleteRegistrationCellVM) {
        self.viewModel = vm
        self.goToAccountButton.setAction(action: vm.goToAccountAction)
        self.goToMainButton.setAction(action: vm.goToMainAction)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        [topSpacer, signInCompletedTitle, signInCompletedSubtitle, goToAccountButton, goToMainButton, bottomSpacer].forEach { vStack.addArrangedSubview($0) }
        
        vStack.setCustomSpacing(10, after: signInCompletedTitle)
        vStack.setCustomSpacing(20, after: signInCompletedSubtitle)
        vStack.setCustomSpacing(20, after: goToAccountButton)
        
        goToAccountButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        goToMainButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.6)
        }
    }
}
