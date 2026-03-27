//
//  ConfirmDeletionPopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit
import SnapKit

struct ConfirmDeletionPopUpViewModel: PopUpViewModel {
    let email: String?
    var didConfirm: ((String?, String?) -> Void)?
    var onClose: (() -> Void)?
}

final class ConfirmDeletionPopUpView: PopUpView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let sSpacing = 5.0
        static let xSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private let vm: ConfirmDeletionPopUpViewModel
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Words.deleteAccountConfirmCode
        label.textColor = .black
        label.font = ECFont.font(.bold, size: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Words.deleteAccountSendEmailWithCode
        label.textColor = .darkGray
        label.font = ECFont.font(.regular, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let codeField: ECTextField = {
        let field = ECTextField(placeHolder: ConstantLocalizedStrings.Common.code)
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        return field
    }()
    
    private lazy var confirmButton: ECButton = {
        let button = ECButton(text: "\(ConstantLocalizedStrings.Common.confirm) \(ConstantLocalizedStrings.Common.code)")
        button.setAction { [weak self] in
            self?.vm.didConfirm?(self?.vm.email, self?.codeField.text)
        }
        return button
    }()
    
    
    // MARK: - LIFECYCLE
    init(viewModel: ConfirmDeletionPopUpViewModel) {
        self.vm = viewModel
        super.init(viewModel: viewModel)
        setupUI()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.sSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(codeField)
        codeField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.xSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.height.equalTo(SharedConstants.textFieldsHeight)
        }
        
        contentView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(codeField.snp.bottom).offset(Constants.xSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
