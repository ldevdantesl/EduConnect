//
//  LoginScreenConfirmRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenConfirmRegistrationCellVM {
    let confirmAction: ((String?) -> Void)?
    let backButtonAction: (() -> Void)?
    let resendAction: (() -> Void)?
    
    init(confirmAction: ((String?) -> Void)? = nil, resendAction: (() -> Void)? = nil, backButtonAction: (() -> Void)? = nil) {
        self.confirmAction = confirmAction
        self.resendAction = resendAction
        self.backButtonAction = backButtonAction
    }
}

final class LoginScreenConfirmRegistrationCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 15.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
        
        static let backButtonImageName = "arrow.left.circle.fill"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenConfirmRegistrationCellVM?
    
    // MARK: - VIEW PROPERTIES
    private let confirmSignInLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page2.confirmSignInTitle
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let checkEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page2.checkEmailSubtitle
        label.font = ECFont.font(.bold, size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let backButton: ECIconButton = ECIconButton()
    
    private let codeField: ECTextField = {
        let field = ECTextField(placeHolder: ConstantLocalizedStrings.Registration.Page2.confirmCodeTextField)
        field.textContentType = .oneTimeCode
        return field
    }()
    
    private let confirmButton: ECButton = ECButton(text: ConstantLocalizedStrings.Common.confirm)
    
    private let resendCodeButton: ECUnderlineButton = ECUnderlineButton(text: ConstantLocalizedStrings.Registration.Page2.resendCodeUnderlineButton)
    
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
    func configure(withVM vm: LoginScreenConfirmRegistrationCellVM) {
        self.viewModel = vm
        self.confirmButton.setAction { [weak self] in vm.confirmAction?(self?.codeField.text)}
        self.resendCodeButton.setAction(action: vm.resendAction)
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
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }

        [topSpacer, confirmSignInLabel, checkEmailLabel, codeField, confirmButton, resendCodeButton, bottomSpacer].forEach { vStack.addArrangedSubview($0) }
        
        vStack.setCustomSpacing(10, after: confirmSignInLabel)
        vStack.setCustomSpacing(20, after: checkEmailLabel)
        vStack.setCustomSpacing(20, after: codeField)
        vStack.setCustomSpacing(20, after: confirmButton)
        
        codeField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        resendCodeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
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
