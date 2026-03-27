//
//  ForgtoPasswordConfirmCodeCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit
import SnapKit

struct ForgotPasswordConfirmCodeCellViewModel {
    let didPressConfirm: ((String?) -> Void)?
    let didPressResendCode: (() -> Void)?
    let didPressBack: (() -> Void)?
}

final class ForgotPasswordConfirmCodeCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 15.0
        static let spacing = 5.0
        static let verticalStackSpacing = 25.0
        
        static let backButtonImageName = "arrow.left.circle.fill"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ForgotPasswordConfirmCodeCellViewModel?
    private var resendTimer: Timer?
    private var remainingSeconds = 0
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Registration.ForgotPassword.confirmCodeTitle
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
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
    
    private let resendCodeButton: ECUnderlineButton = ECUnderlineButton(
        text: ConstantLocalizedStrings.Registration.Page2.resendCodeUnderlineButton
    )
    
    private let topSpacer = UIView()
    private let bottomSpacer = UIView()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resendTimer?.invalidate()
        resendTimer = nil
        resendCodeButton.isEnabled = true
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: ForgotPasswordConfirmCodeCellViewModel) {
        self.viewModel = vm
        self.confirmButton.setAction { [weak self] in vm.didPressConfirm?(self?.codeField.text)}
        self.resendCodeButton.setAction { [weak self] in
            vm.didPressResendCode?()
            self?.startResendCooldown()
        }
        let backButtonVM = ECIconButtonVM(
            systemImage: Constants.backButtonImageName,
            style: .title3, weight: .semibold,
            didTapAction: vm.didPressBack
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

        [topSpacer, titleLabel, subtitleLabel, codeField, confirmButton, resendCodeButton, bottomSpacer].forEach { vStack.addArrangedSubview($0) }
        
        vStack.setCustomSpacing(10, after: titleLabel)
        vStack.setCustomSpacing(20, after: subtitleLabel)
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
    
    private func startResendCooldown() {
        remainingSeconds = 60
        resendCodeButton.isEnabled = false
        updateResendTitle()
        
        resendTimer?.invalidate()
        resendTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            self.remainingSeconds -= 1
            if self.remainingSeconds <= 0 {
                timer.invalidate()
                self.resendTimer = nil
                self.resendCodeButton.isEnabled = true
                self.resendCodeButton.setTitle(
                    ConstantLocalizedStrings.Registration.Page2.resendCodeUnderlineButton
                )
            } else {
                self.updateResendTitle()
            }
        }
    }

    private func updateResendTitle() {
        resendCodeButton.setTitle(
            "\(ConstantLocalizedStrings.Registration.Page2.resendCodeUnderlineButton) (\(remainingSeconds)s)"
        )
    }
}
