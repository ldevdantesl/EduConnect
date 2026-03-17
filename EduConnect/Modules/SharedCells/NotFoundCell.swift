//
//  NotFoundCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.02.2026.
//

import UIKit
import SnapKit

struct NotFoundCellViewModel {
    let image: UIImage?
    let title: String
    let subtitle: String?
    let onTapAction: (() -> Void)?
    let horizontallySpaced: Bool
    
    init(image: UIImage? = nil, title: String = ConstantLocalizedStrings.Words.notFound, subtitle: String? = nil, horizontallySpaced: Bool = false, onTapAction: (() -> Void)? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.onTapAction = onTapAction
        self.horizontallySpaced = horizontallySpaced
    }
    
    init(systemImage: String, title: String = ConstantLocalizedStrings.Words.notFound, subtitle: String? = nil, horizontallySpaced: Bool = false, onTapAction: (() -> Void)? = nil) {
        self.image = UIImage(systemName: systemImage)
        self.title = title
        self.subtitle = subtitle
        self.onTapAction = onTapAction
        self.horizontallySpaced = horizontallySpaced
    }
}

final class NotFoundCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let imageSize = 60.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: NotFoundCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = ECFont.font(.semiBold, size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        return view
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
        containerView.layer.cornerRadius = 15.0
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        containerView.applyFloatingShadow()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: NotFoundCellViewModel) {
        self.viewModel = vm
        self.imageView.image = vm.image
        self.titleLabel.text = vm.title
        self.subtitleLabel.text = vm.subtitle
        setupConstraints(horizontallySpaced: vm.horizontallySpaced)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
    }
    
    private func setupConstraints(horizontallySpaced: Bool) {
        containerView.snp.remakeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(horizontallySpaced ? Constants.spacing : 0)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTap() {
        self.animateTap { [weak self] in
            self?.viewModel?.onTapAction?()
        }
    }
}

