//
//  LoginScreenLoginCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 19.02.2026.
//

import UIKit
import SnapKit

struct LoginScreenLoginCellViewModel {
    let didPressLogin: ((String?, String?) -> Void)?
    let didPressRegister: (() -> Void)?
    let didPressForgotPassword: (() -> Void)?
    
    init(didPressLogin: ((String?, String?) -> Void)? = nil, didPressRegister: (() -> Void)? = nil, didPressForgotPassword: (() -> Void)?) {
        self.didPressLogin = didPressLogin
        self.didPressRegister = didPressRegister
        self.didPressForgotPassword = didPressForgotPassword
    }
}

final class LoginScreenLoginCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 15.0
        static let verticalStackSpacing = 25.0
        static let spacing = 5.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenLoginCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Words.login
        label.textColor = .black
        label.font = ECFont.font(.bold, size: 26)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var loginTypeSwitcher: UISegmentedControl = {
        let control = UISegmentedControl(items: [ConstantLocalizedStrings.Registration.Words.email, ConstantLocalizedStrings.Registration.Words.phone])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .systemBlue
        control.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: ECFont.font(.semiBold, size: 14)], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor.label, .font: ECFont.font(.medium, size: 14)], for: .normal)
        control.addTarget(self, action: #selector(loginTypeChanged(_:)), for: .valueChanged)
        return control
    }()
    
    private let emailField: ECTextField = {
        let field = ECTextField(placeHolder: ConstantLocalizedStrings.Registration.Page1.enterEmailTextField, returnKeyType: .next)
        field.keyboardType = .emailAddress
        field.textContentType = .username
        return field
    }()
    
    private let passwordField: ECSecureTextField = {
        let field = ECSecureTextField(placeHolder: ConstantLocalizedStrings.Registration.Page1.enterPasswordTextField, returnKeyType: .done)
        field.textContentType = .password
        return field
    }()
    
    private let loginButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Registration.Words.login)
        return button
    }()
    
    private let registerButton: ECUnderlineButton = {
        let button = ECUnderlineButton(text: ConstantLocalizedStrings.Registration.Words.register)
        return button
    }()
    private let forgotPassword: ECUnderlineButton = {
        let button = ECUnderlineButton(text: "Forgot Password")
        return button
    }()
    
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
    func configure(withVM vm: LoginScreenLoginCellViewModel) {
        self.viewModel = vm
        loginButton.setAction { [weak self] in vm.didPressLogin?(self?.emailField.text, self?.passwordField.text) }
        registerButton.setAction(action: vm.didPressRegister)
        forgotPassword.setAction(action: vm.didPressForgotPassword)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        [topSpacer, loginTitleLabel, loginTypeSwitcher, emailField, passwordField, loginButton, registerButton, forgotPassword, bottomSpacer].forEach {
            vStack.addArrangedSubview($0)
        }
        
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: loginTitleLabel)
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: loginTypeSwitcher)
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: emailField)
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: passwordField)
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: registerButton)
        vStack.setCustomSpacing(Constants.hSpacing, after: loginButton)
        
        loginTypeSwitcher.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        emailField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        passwordField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.6)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func loginTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            emailField.placeholder = ConstantLocalizedStrings.Registration.Page1.enterEmailTextField
            emailField.keyboardType = .emailAddress
            emailField.textContentType = .username
        } else {
            emailField.placeholder = ConstantLocalizedStrings.Registration.Page1.enterPhoneTextField
            emailField.keyboardType = .phonePad
            emailField.textContentType = .telephoneNumber
        }
    }
}
