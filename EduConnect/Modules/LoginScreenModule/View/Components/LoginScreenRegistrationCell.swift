//
//  LoginScreenRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenRegistrationCellViewModel: CellViewModel {
    var cellIdentifier: String = "LoginScreenRegistrationCell"
    let didTapSendCode: (() -> Void)?
}

final class LoginScreenRegistrationCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Other
        static let cornerRadius = 15.0
        
        // Heights
        static let textFieldHeight = 60
        static let sendCodeButtonHeight = 50
        
        //Spacings
        static let hSpacing = 15.0
        static let vSpacing = 10.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenRegistrationCellViewModel?
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    
    // MARK: - VIEW PROPERTIES
    private let signInTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = ECLocalizedStrings.Registration.signIn
        label.font = ECFont.font(.extraBold, size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let enterEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.enterEmail
        label.font = ECFont.font(.medium, size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: ECTextField = {
        let textField = ECTextField(placeHolder: ECLocalizedStrings.Registration.enterEmailTextField, cornerRadius: Constants.cornerRadius)
        textField.placeholder = ECLocalizedStrings.Registration.enterEmail
        textField.font = ECFont.font(.medium, size: 14)
        textField.textAlignment = .left
        return textField
    }()
    
    private let sendCodeButton: ECButton = {
        let button = ECButton(text: ECLocalizedStrings.Registration.sendCodeButton)
        return button
    }()
    
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
        self.vStack.layer.cornerRadius = Constants.cornerRadius
    }
    
    // MARK: - PUBLIC FUNX
    public func configure(withVM vm: CellViewModel) {
        guard let vm = vm as? LoginScreenRegistrationCellViewModel else { return }
        self.viewModel = vm
        self.sendCodeButton.setAction(action: vm.didTapSendCode)
        layoutIfNeeded()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        topSpacer.backgroundColor = .clear
        bottomSpacer.backgroundColor = .clear
        topSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        bottomSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        topSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        bottomSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        vStack.addArrangedSubview(topSpacer)
        vStack.addArrangedSubview(signInTitleLabel)
        vStack.setCustomSpacing(10, after: signInTitleLabel)
        vStack.addArrangedSubview(enterEmailLabel)
        vStack.setCustomSpacing(30, after: enterEmailLabel)
        
        vStack.addArrangedSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(Constants.textFieldHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: emailTextField)
        
        vStack.addArrangedSubview(sendCodeButton)
        sendCodeButton.snp.makeConstraints {
            $0.height.equalTo(Constants.sendCodeButtonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.addArrangedSubview(bottomSpacer)
        topSpacer.heightAnchor.constraint(equalTo: bottomSpacer.heightAnchor).isActive = true
        
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
    }
    
    // MARK: - OBJC FUNC
}
