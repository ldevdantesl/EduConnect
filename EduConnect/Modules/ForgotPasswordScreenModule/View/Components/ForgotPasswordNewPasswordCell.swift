//
//  ForgotPasswordNewPasswordCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit
import SnapKit

struct ForgotPasswordNewPasswordCellViewModel {
    let didTapSave: ((String?, String?) -> Void)?
    let didTapBack: (() -> Void)?
    
    init(didTapSave: ((String?, String?) -> Void)? = nil, didTapBack: (() -> Void)? = nil) {
        self.didTapSave = didTapSave
        self.didTapBack = didTapBack
    }
}

final class ForgotPasswordNewPasswordCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Spacing
        static let hSpacing = 15.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
        
        static let backButtonImageName = "arrow.left.circle.fill"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ForgotPasswordNewPasswordCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let setPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.ForgotPassword.setNewPasswordTitle
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let setPasswordSubtitle: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.ForgotPassword.setNewPasswordSubtitle
        label.font = ECFont.font(.regular, size: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var passwordField: ECTextField = {
        let field = ECSecureTextField(
            placeHolder: ConstantLocalizedStrings.Registration.Page3.newPasswordTextField,
            returnKeyType: .next,
            returnAction: self.makeReenterFieldFirstResponder
        )
        field.textContentType = .newPassword
        return field
    }()
    
    private let reenterPasswordField: ECTextField = {
        let field = ECSecureTextField(placeHolder: ConstantLocalizedStrings.Registration.Page3.reenterPasswordTextField)
        field.textContentType = .newPassword
        return field
    }()
    
    private let savePasswordButton: ECButton = ECButton(text: ConstantLocalizedStrings.Registration.Page3.savePasswordButton)
    
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
    
    private let backButton: ECIconButton = ECIconButton()
    
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
    public func configure(withVM vm: ForgotPasswordNewPasswordCellViewModel) {
        self.viewModel = vm
        self.savePasswordButton.setAction { [weak self] in vm.didTapSave?(self?.passwordField.text, self?.reenterPasswordField.text) }
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
        
        [topSpacer, setPasswordLabel, setPasswordSubtitle, passwordField, reenterPasswordField, savePasswordButton, bottomSpacer].forEach { vStack.addArrangedSubview($0) }
        
        vStack.setCustomSpacing(10, after: setPasswordLabel)
        vStack.setCustomSpacing(20, after: setPasswordSubtitle)
        vStack.setCustomSpacing(20, after: passwordField)
        vStack.setCustomSpacing(20, after: reenterPasswordField)
        vStack.setCustomSpacing(20, after: savePasswordButton)
        
        passwordField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        reenterPasswordField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        savePasswordButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.5)
        }
        
        vStack.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
    }
    
    private func makeReenterFieldFirstResponder() {
        self.reenterPasswordField.becomeFirstResponder()
    }
}
