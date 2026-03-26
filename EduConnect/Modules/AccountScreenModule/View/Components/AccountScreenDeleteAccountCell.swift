//
//  AccountScreenDeleteButtonCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 25.03.2026.
//

import UIKit
import SnapKit

struct AccountScreenDeleteAccountCellViewModel {
    let didTapDelete: (() -> Void)?
    
    init(didTapDelete: (() -> Void)? = nil) {
        self.didTapDelete = didTapDelete
    }
}

final class AccountScreenDeleteAccountCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let trashImageSize = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenDeleteAccountCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var deleteButton: UIView = makeDeleteButton()
    
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
    public func configure(withVM vm: AccountScreenDeleteAccountCellViewModel) {
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
    
    private func makeDeleteButton() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        let label = UILabel()
        label.text = "Delete Account"
        label.font = ECFont.font(.bold, size: 16)
        label.textColor = .white
        label.numberOfLines = 1
        
        let image = UIImageView()
        image.image = ImageConstants.SystemImages.trash.image
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
        
        view.addSubview(image)
        image.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.leading.equalTo(label.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.trashImageSize)
        }

        return view
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTap() {
        deleteButton.animateTap { [weak self] in
            self?.viewModel?.didTapDelete?()
        }
    }
}
