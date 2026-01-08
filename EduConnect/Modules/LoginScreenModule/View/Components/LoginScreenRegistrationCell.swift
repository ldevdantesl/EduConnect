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
}

final class LoginScreenRegistrationCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Other
        static let cornerRadius = 15.0
        static let buttonCornerRadius = 25.0
        
        // Heights
        static let textFieldHeight = 70
        static let sendCodeButtonHeight = 60
        
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
        label.font = ECFont.font(.bold, size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ECLocalizedStrings.Registration.enterEmail
        textField.font = ECFont.font(.medium, size: 14)
        textField.textAlignment = .center
        return textField
    }()
    
    private let sendCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send Code", for: .normal)
        button.configuration = .borderedProminent()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 0
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
        self.sendCodeButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
    
    // MARK: - PUBLIC FUNX
    public func configure(withVM vm: CellViewModel) {
        guard let vm = vm as? LoginScreenRegistrationCellViewModel else { return }
        self.viewModel = vm
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
