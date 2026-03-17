//
//  HomeScreenMainTabInfoCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import UIKit
import SnapKit

struct AccountScreenMainTabInfoCellViewModel {
    let cellIdentifier: String = AccountScreenMainTabInfoCell.identifier
}

final class AccountScreenMainTabInfoCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenMainTabInfoCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let welcomeMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ConstantLocalizedStrings.Account.MainTab.welcomeMessage
        label.font = ECFont.font(.regular, size: 16)
        return label
    }()
    
    private let adviceSectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = ConstantLocalizedStrings.Account.MainTab.adviceSection
        label.font = ECFont.font(.bold, size: 17)
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ConstantLocalizedStrings.Account.MainTab.adviceSubtitle
        label.font = ECFont.font(.regular, size: 16)
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeMessageLabel, adviceSectionLabel, adviceLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Constants.spacing
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
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: AccountScreenMainTabInfoCellViewModel) {
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
