//
//  LoginScreenRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenRegistrationCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "LoginScreenRegistrationCell"
    let didTapSendCode: ((String?) -> Void)?
}

final class LoginScreenRegistrationCell: UICollectionViewCell, ConfigurableCellProtocol {
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
    
    private let enterEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.Page1.enterEmailSubtitle
        label.font = ECFont.font(.medium, size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: ECTextField = ECTextField(placeHolder: ConstantLocalizedStrings.Registration.Page1.enterEmailTextField)
    
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
    public func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? LoginScreenRegistrationCellViewModel else { return }
        self.viewModel = vm
        self.sendCodeButton.setAction { [weak self] in vm.didTapSendCode?(self?.emailTextField.text) }
        layoutIfNeeded()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        emailTextField.keyboardType = .emailAddress
        topSpacer.backgroundColor = .clear
        topSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        topSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        bottomSpacer.backgroundColor = .clear
        bottomSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        bottomSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        vStack.addArrangedSubview(topSpacer)
        vStack.addArrangedSubview(signInTitleLabel)
        vStack.setCustomSpacing(10, after: signInTitleLabel)
        vStack.addArrangedSubview(enterEmailLabel)
        vStack.setCustomSpacing(30, after: enterEmailLabel)
        
        vStack.addArrangedSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.textFieldsHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: emailTextField)
        
        vStack.addArrangedSubview(sendCodeButton)
        sendCodeButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
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
    }
}
