//
//  LoginScreenLoginCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 19.02.2026.
//

import UIKit
import SnapKit

struct LoginScreenLoginCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = LoginScreenLoginCell.identifier
    let didPressLogin: ((String?, String?) -> Void)?
    let didPressRegister: (() -> Void)?
    
    init(didPressLogin: ((String?, String?) -> Void)? = nil, didPressRegister: (() -> Void)? = nil) {
        self.didPressLogin = didPressLogin
        self.didPressRegister = didPressRegister
    }
}

final class LoginScreenLoginCell: UICollectionViewCell, ConfigurableCellProtocol {
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
    
    private let emailField: ECTextField = {
        let field = ECTextField(placeHolder: "Введите email", returnKeyType: .next)
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let passwordField: ECSecureTextField = {
        let field = ECSecureTextField(placeHolder: "Введите пароль", returnKeyType: .done)
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
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? LoginScreenLoginCellViewModel else { return }
        self.viewModel = vm
        loginButton.setAction { [weak self] in vm.didPressLogin?(self?.emailField.text, self?.passwordField.text) }
        registerButton.setAction(action: vm.didPressRegister)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        topSpacer.backgroundColor = .clear
        topSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        topSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        bottomSpacer.backgroundColor = .clear
        bottomSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        bottomSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        vStack.addArrangedSubview(topSpacer)
        vStack.addArrangedSubview(loginTitleLabel)
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: loginTitleLabel)
        vStack.addArrangedSubview(emailField)
        emailField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: emailField)
        
        vStack.addArrangedSubview(passwordField)
        passwordField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(Constants.verticalStackSpacing, after: passwordField)
        
        vStack.addArrangedSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(Constants.hSpacing, after: loginButton)
        
        vStack.addArrangedSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        vStack.addArrangedSubview(bottomSpacer)
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.6)
        }
        
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        layoutIfNeeded()
    }
}
