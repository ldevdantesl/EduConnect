//
//  LoginScreenSetPasswordCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenSetPasswordCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "LoginScreenSetPasswordCell"
    let savePasswordAction: ((String?, String?) -> Void)?
    let backButtonAction: (() -> Void)?
    
    init(savePasswordAction: ((String?, String?) -> Void)? = nil, backButtonAction: (() -> Void)? = nil) {
        self.savePasswordAction = savePasswordAction
        self.backButtonAction = backButtonAction
    }
}

final class LoginScreenSetPasswordCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Spacing
        static let hSpacing = 15.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
        
        static let backButtonImageName = "arrow.left.circle.fill"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenSetPasswordCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let setPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page3.setPasswordTitle
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let setPasswordSubtitle: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page3.setNewPasswordSubtitle
        label.font = ECFont.font(.bold, size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var passwordField: ECTextField = {
        let field = ECSecureTextField(
            placeHolder: ConstantLocalizedStrings.Registration.Page3.newPasswordTextField,
            returnKeyType: .next,
            returnAction: self.makeReenterFieldFirstResponder
        )
        return field
    }()
    private let reenterPasswordField: ECTextField = ECSecureTextField(placeHolder: ConstantLocalizedStrings.Registration.Page3.reenterPasswordTextField)
    
    private let savePasswordButton: ECButton = ECButton(text: ConstantLocalizedStrings.Registration.Page3.savePasswordButton)
    
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
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? LoginScreenSetPasswordCellViewModel else { return }
        self.viewModel = vm
        self.savePasswordButton.setAction { [weak self] in
            vm.savePasswordAction?(self?.passwordField.text, self?.reenterPasswordField.text)
        }
        let backButtonVM = ECIconButtonVM(
            systemImage: Constants.backButtonImageName,
            style: .title3, weight: .semibold,
            didTapAction: vm.backButtonAction
        )
        self.backButton.configure(viewModel: backButtonVM)
        layoutIfNeeded()
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
        vStack.addArrangedSubview(setPasswordLabel)
        vStack.setCustomSpacing(10, after: setPasswordLabel)
        vStack.addArrangedSubview(setPasswordSubtitle)
        vStack.setCustomSpacing(20, after: setPasswordSubtitle)
        
        vStack.addArrangedSubview(passwordField)
        passwordField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: passwordField)
        
        vStack.addArrangedSubview(reenterPasswordField)
        reenterPasswordField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: reenterPasswordField)
        
        vStack.addArrangedSubview(savePasswordButton)
        savePasswordButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: savePasswordButton)
        
        vStack.addArrangedSubview(bottomSpacer)
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.5)
        }
        
        vStack.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        self.contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.addArrangedSubview(bottomSpacer)
        layoutIfNeeded()
    }
    
    private func makeReenterFieldFirstResponder() {
        self.reenterPasswordField.becomeFirstResponder()
    }
}
