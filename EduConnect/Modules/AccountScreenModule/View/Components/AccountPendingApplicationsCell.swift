//
//  AccountPendingApplicationsCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import UIKit
import SnapKit

struct AccountPendingApplicationsCellViewModel {
    let application: Application
    var didTapUniversity: ((Int) -> Void)? = nil
}

final class AccountPendingApplicationsCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let semiSpacing = 5.0
        
        static let imageSize = 40.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountPendingApplicationsCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let fileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "doc")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .blue
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapUniversity)))
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = ECFont.font(.regular, size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [fileImageView, vStack])
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .top
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
    public func configure(withVM vm: AccountPendingApplicationsCellViewModel) {
        self.viewModel = vm
        self.dateLabel.text = ECDateFormatter.formatISODate(vm.application.submittedAt, formatType: .dateWithTime)
        
        var attrName = AttributedString(vm.application.university.name)
        attrName.foregroundColor = .blue
        attrName.font = ECFont.font(.semiBold, size: 14)
        attrName.underlineStyle = .single
        attrName.underlineColor = .blue
        
        self.nameLabel.attributedText = NSAttributedString(attrName)
    }
    
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fileImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.imageSize)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapUniversity() {
        guard let vm = viewModel else { return }
        self.animateTap {
            vm.didTapUniversity?(vm.application.university.id)
        }
    }
}
