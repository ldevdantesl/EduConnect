//
//  LoginScreenCompleteRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit
import SnapKit

struct LoginScreenCompleteRegistrationCellVM: CellViewModel {
    var cellIdentifier: String = "LoginScreenCompleteRegistrationCell"
    let goToAccountAction: (() -> Void)?
    let goToMainAction: (() -> Void)?
    
    init(goToAccountAction: (() -> Void)? = nil, goToMainAction: (() -> Void)? = nil) {
        self.goToAccountAction = goToAccountAction
        self.goToMainAction = goToMainAction
    }
}

final class LoginScreenCompleteRegistrationCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // Spacing
        static let hSpacing = 15.0
        static let verticalStackSpacing = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: LoginScreenCompleteRegistrationCellVM?
    
    // MARK: - VIEW PROPERTIES
    private let signInCompletedTitle: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.Page4.signInCompletedTitle
        label.font = ECFont.font(.bold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let signInCompletedSubtitle: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.Page4.signInCompletedSubtitle
        label.font = ECFont.font(.bold, size: 14)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let goToAccountButton: ECButton = ECButton(text: ECLocalizedStrings.Registration.Page4.goToAccountButton)
    private let goToMainButton: ECButton = ECButton(text: ECLocalizedStrings.Registration.Page4.goToMainButton)
    
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
        guard let vm = vm as? LoginScreenCompleteRegistrationCellVM else { return }
        self.viewModel = vm
        self.goToAccountButton.setAction(action: vm.goToAccountAction)
        self.goToMainButton.setAction(action: vm.goToMainAction)
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
        vStack.addArrangedSubview(signInCompletedTitle)
        vStack.setCustomSpacing(10, after: signInCompletedTitle)
        vStack.addArrangedSubview(signInCompletedSubtitle)
        vStack.setCustomSpacing(20, after: signInCompletedSubtitle)
        
        vStack.addArrangedSubview(goToAccountButton)
        goToAccountButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        vStack.setCustomSpacing(20, after: goToAccountButton)
        
        vStack.addArrangedSubview(goToMainButton)
        goToMainButton.snp.makeConstraints {
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
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
}
