//
//  ForgotPasswordTypePasswordCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit
import SnapKit

struct ForgotPasswordTypeEmailCellViewModel {
    let didTapBack: (() -> Void)?
    let didTapEmail: ((String?) -> Void)?
}

final class ForgotPasswordTypeEmailCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 15.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
        
        static let backButtonImageName = "arrow.left.circle.fill"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ForgotPasswordTypeEmailCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password"
        label.font = ECFont.font(.bold, size: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Type your email to reset your password"
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let emailField: ECTextField = {
        let field = ECTextField(placeHolder: ConstantLocalizedStrings.Registration.Words.email)
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let continueButton: ECButton = ECButton(text: ConstantLocalizedStrings.Common.continue)
    
    private let backButton: ECIconButton = ECIconButton()
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    
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
    public func configure(withVM vm: ForgotPasswordTypeEmailCellViewModel) {
        self.viewModel = vm
        self.continueButton.setAction { [weak self] in vm.didTapEmail?(self?.emailField.text) }
        let backButtonVM = ECIconButtonVM(
            systemImage: Constants.backButtonImageName,
            style: .title3, weight: .semibold,
            didTapAction: vm.didTapBack
        )
        self.backButton.configure(viewModel: backButtonVM)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }

        [topSpacer, titleLabel, subtitleLabel, emailField, continueButton, bottomSpacer].forEach { vStack.addArrangedSubview($0) }
        
        vStack.setCustomSpacing(10, after: titleLabel)
        vStack.setCustomSpacing(20, after: subtitleLabel)
        vStack.setCustomSpacing(20, after: emailField)
        
        emailField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        continueButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.6)
        }
        
        vStack.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
    }
}
