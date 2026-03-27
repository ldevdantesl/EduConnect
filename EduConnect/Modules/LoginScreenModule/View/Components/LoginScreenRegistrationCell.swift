//
//  LoginScreenRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenRegistrationCellViewModel {
    let didPressBack: (() -> Void)?
    let didTapSendCode: ((String?) -> Void)?
    let didTapPhone: (() -> Void)?
}

final class LoginScreenRegistrationCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
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
        label.text = ConstantLocalizedStrings.Registration.Page1.signInTitle
        label.font = ECFont.font(.extraBold, size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
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
    
    private let backButton: ECIconButton = {
        let backButtonVM = ECIconButtonVM(
            systemImage: ImageConstants.SystemImages.chevronLeft.rawValue,
            style: .title3, weight: .semibold
        )
        let button = ECIconButton(viewModel: backButtonVM)
        return button
    }()
    
    private let enterEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page1.enterEmailSubtitle
        label.font = ECFont.font(.medium, size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: ECTextField = {
        let field = ECTextField(placeHolder: ConstantLocalizedStrings.Registration.Page1.enterEmailTextField)
        field.keyboardType = .emailAddress
        field.textContentType = .username
        return field
    }()
    
    private let sendCodeButton: ECButton = ECButton(text: ConstantLocalizedStrings.Registration.Page1.sendCodeButton)
    
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
    
    // MARK: - PUBLIC FUNX
    public func configure(withVM vm: LoginScreenRegistrationCellViewModel) {
        self.viewModel = vm
        self.sendCodeButton.setAction { [weak self] in vm.didTapSendCode?(self?.emailTextField.text) }
        self.backButton.setAction(action: vm.didPressBack)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        [topSpacer, signInTitleLabel, enterEmailLabel, loginTypeSwitcher, emailTextField, sendCodeButton, bottomSpacer].forEach {
            vStack.addArrangedSubview($0)
        }
        
        vStack.setCustomSpacing(10, after: signInTitleLabel)
        vStack.setCustomSpacing(20, after: enterEmailLabel)
        vStack.setCustomSpacing(20, after: loginTypeSwitcher)
        vStack.setCustomSpacing(20, after: emailTextField)
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        sendCodeButton.snp.makeConstraints {
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
        
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.6)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func loginTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            emailTextField.placeholder = ConstantLocalizedStrings.Registration.Page1.enterEmailTextField
            emailTextField.keyboardType = .emailAddress
            emailTextField.textContentType = .username
        } else {
            self.viewModel?.didTapPhone?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.loginTypeSwitcher.selectedSegmentIndex = 0
            }
//            emailTextField.placeholder = ConstantLocalizedStrings.Registration.Page1.enterPhoneTextField
//            emailTextField.keyboardType = .phonePad
//            emailTextField.textContentType = .telephoneNumber
        }
    }
}
