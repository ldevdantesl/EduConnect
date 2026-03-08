//
//  MainScreenAcademicShowAllCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.02.2026.
//

import UIKit
import SnapKit

struct MainScreenAcademicShowAllCellViewModel {
    let title: String
    let didTapAction: (() -> Void)?
    
    init(title: String, didTapAction: (() -> Void)? = nil) {
        self.didTapAction = didTapAction
        self.title = title
    }
}

final class MainScreenAcademicShowAllCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let smallSpacing = 10.0
        static let hSpacing = 50.0
        static let spacing = 20.0
        static let viewHeight = 250.0
        static let imageSize = 30.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenAcademicShowAllCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBlue
        container.isUserInteractionEnabled = true
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAction)))
        return container
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 16)
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = ImageConstants.SystemImages.chevronRight.image
        iv.tintColor = .white
        return iv
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
        self.container.layer.cornerRadius = 30
        self.container.applyFloatingShadow()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenAcademicShowAllCellViewModel) {
        self.viewModel = vm
        titleLabel.text = vm.title
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.smallSpacing)
        }
        
        container.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing * 2)
            $0.trailing.equalToSuperview().offset(-Constants.hSpacing)
            $0.size.equalTo(Constants.imageSize)
        }
        
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.hSpacing * 2)
            $0.leading.equalToSuperview().offset(Constants.hSpacing)
            $0.trailing.equalTo(imageView.snp.leading).offset(-Constants.spacing)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapAction() {
        animateTap(onCompletion: viewModel?.didTapAction)
    }
}
