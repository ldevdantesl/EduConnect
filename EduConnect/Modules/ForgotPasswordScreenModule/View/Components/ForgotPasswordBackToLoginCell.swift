//
//  ForgotPasswordBackToLoginCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit
import SnapKit

struct ForgotPasswordBackToLoginCellViewModel {
    let didTapBackToLogin: (() -> Void)?
}

final class ForgotPasswordBackToLoginCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 15.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ForgotPasswordBackToLoginCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.ForgotPassword.newPasswordSetTitle
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = ECFont.font(.bold, size: 30)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.ForgotPassword.newPasswordSetSubtitle
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = ECFont.font(.regular, size: 14)
        return label
    }()
    
    private let backToLoginButton: ECButton = ECButton(text: ConstantLocalizedStrings.Registration.ForgotPassword.backToLogin)
    
    private let vStack: UIStackView = {
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
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    
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
    public func configure(withVM vm: ForgotPasswordBackToLoginCellViewModel) {
        self.viewModel = vm
        self.backToLoginButton.setAction(action: vm.didTapBackToLogin)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        [topSpacer, titleLabel, subtitleLabel, backToLoginButton, bottomSpacer].forEach { vStack.addArrangedSubview($0) }
        
        vStack.setCustomSpacing(10, after: titleLabel)
        vStack.setCustomSpacing(50, after: subtitleLabel)
        
        backToLoginButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
        }
        
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.5)
        }
    }
    
    // MARK: - OBJC FUNC
}
