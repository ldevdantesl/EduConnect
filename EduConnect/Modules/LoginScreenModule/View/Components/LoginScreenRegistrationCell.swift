//
//  LoginScreenRegistrationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit
import SnapKit

final class LoginScreenRegistrationCell: ECCollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        //Spacings
        static let hSpacing = 20
        static let vSpacing = 10
    }
    
    // MARK: - VIEW PROPERTIES
    private let signInTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.signIn
        label.font = ECFont.font(.bold, size: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let enterEmailLabel: UILabel = {
        let label = UILabel()
        label.text = ECLocalizedStrings.Registration.enterEmail
        label.font = ECFont.font(.medium, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
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
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        vStack.addArrangedSubview(signInTitleLabel)
        vStack.addArrangedSubview(enterEmailLabel)
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - OBJC FUNC
}
