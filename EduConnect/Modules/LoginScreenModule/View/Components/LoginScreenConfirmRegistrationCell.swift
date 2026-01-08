//
//  LoginScreenConfirmRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenConfirmRegistrationCellVM: CellViewModel {
    var cellIdentifier: String = "LoginScreenConfirmRegistrationCell"
    let confirmAction: (() -> Void)?
    let resendAction: (() -> Void)?
    
    init(confirmAction: (() -> Void)? = nil, resendAction: (() -> Void)? = nil) {
        self.confirmAction = confirmAction
        self.resendAction = resendAction
    }
}

final class LoginScreenConfirmRegistrationCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Spacing
        static let hSpacing = 15.0
        static let verticalStackSpacing = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenConfirmRegistrationCellVM?
    
    // MARK: - VIEW PROPERTIES
    private let confirmSignInLabel: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.confirmSignIn
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let checkEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.checkEmail
        label.font = ECFont.font(.bold, size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let codeField: ECTextField = ECTextField(placeHolder: ECLocalizedStrings.Registration.confirmCodeTextField)
    
    private let confirmButton: ECButton = ECButton(text: ECLocalizedStrings.Common.confirm)
    
    private let resendCodeButton: ECUnderlineButton = ECUnderlineButton(text: ECLocalizedStrings.Registration.resendCode)
    
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
    func configure(withVM vm: any CellViewModel) {
        guard let vm = vm as? LoginScreenConfirmRegistrationCellVM else { return }
        self.viewModel = vm
        self.confirmButton.setAction(action: vm.confirmAction)
        self.resendCodeButton.setAction(action: vm.resendAction)
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
        vStack.addArrangedSubview(confirmSignInLabel)
        vStack.setCustomSpacing(10, after: confirmSignInLabel)
        vStack.addArrangedSubview(checkEmailLabel)
        vStack.setCustomSpacing(20, after: checkEmailLabel)
        
        vStack.addArrangedSubview(codeField)
        codeField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: codeField)
        
        vStack.addArrangedSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: confirmButton)
        
        vStack.addArrangedSubview(resendCodeButton)
        resendCodeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        vStack.addArrangedSubview(bottomSpacer)
        topSpacer.snp.makeConstraints {
            $0.height.equalTo(bottomSpacer.snp.height).multipliedBy(0.6)
        }
        
        self.contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.verticalStackSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.addArrangedSubview(bottomSpacer)
        layoutIfNeeded()
    }
    
    // MARK: - OBJC FUNC
}
