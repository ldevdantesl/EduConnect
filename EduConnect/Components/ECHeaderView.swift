//
//  ECHeader.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 3.01.2026.
//

import UIKit
import SnapKit

final class ECHeaderView: UIView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // AccountButton
        static let accountButtonImageName = "person"
        static let accountButtonColor: UIColor = UIColor.systemBlue
        static let accountButtonSize = 44
        
        // Spacing
        static let vSpacing = 10.0
        static let hSpacing = 10.0
    }
    
    // MARK: - VIEW PROPERTIES
    private let accountButton: ECIconButton = {
        let vm = ECIconButtonVM(
            systemImage: Constants.accountButtonImageName,
            color: Constants.accountButtonColor,
            style: .title3, weight: .heavy
        ) {
            print("Tapped Account Button")
        }
        let button = ECIconButton(viewModel: vm)
        return button
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
        self.isUserInteractionEnabled = true
        self.backgroundColor = .systemGray6
        self.addSubview(accountButton)
        
        accountButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.hSpacing)
            $0.size.equalTo(Constants.accountButtonSize)
        }
    }
}
