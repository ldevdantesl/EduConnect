//
//  DeletableFileView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct DeletableFileViewModel {
    let title: String
    let subtitle: String?
    let onDelete: (() -> Void)?
    let imageURLs: [String]
    
    init(title: String, subtitle: String? = nil, imageURLs: [String] = [], onDelete: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.onDelete = onDelete
        self.imageURLs = imageURLs
    }
}

final class DeletableFileView: UIView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 10.0
        static let spacing = 5.0
        static let buttonSize = 30.0
        static let cornerRadius = 10.0
        static let imageSize = 50.0
        static let scrollSize = 70.0
        static let badgeSize = 20.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: DeletableFileViewModel
    private var onDelete: (() -> Void)?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .label
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [deleteButton, vStack])
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ImageConstants.SystemImages.trash.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()
    
    private let filesScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()

    private let filesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: DeletableFileViewModel) {
        self.viewModel = viewModel
        self.onDelete = viewModel.onDelete
        super.init(frame: .zero)
        setup()
        populateImages()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    func setDeleteAction(action: (() -> Void)?) {
        self.onDelete = action
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        
        addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().offset(Constants.spacing)
        }
        
        addSubview(filesScrollView)
        filesScrollView.snp.makeConstraints {
            $0.top.equalTo(hStack.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
            $0.bottom.equalToSuperview().inset(Constants.hSpacing)
            $0.height.equalTo(viewModel.imageURLs.isEmpty ? 0 : Constants.scrollSize)
        }
        
        filesScrollView.addSubview(filesStack)
        filesStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    private func populateImages() {
        filesStack.arrangedSubviews.forEach { filesStack.removeArrangedSubview($0); $0.removeFromSuperview() }
        
        viewModel.imageURLs.enumerated().forEach { index, urlString in
            guard let url = URL(string: urlString) else { return }
            
            let container = UIView()
            
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = Constants.cornerRadius
            iv.kf.setImage(with: url, placeholder: ImageConstants.SystemImages.folder.image)
            
            let badge = UILabel()
            badge.text = "\(index + 1)"
            badge.font = ECFont.font(.semiBold, size: 10)
            badge.textColor = .white
            badge.textAlignment = .center
            badge.backgroundColor = .systemGray
            badge.layer.cornerRadius = Constants.badgeSize / 2
            badge.clipsToBounds = true
            
            container.addSubview(iv)
            iv.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.size.equalTo(Constants.imageSize)
            }
            
            container.addSubview(badge)
            badge.snp.makeConstraints {
                $0.top.equalToSuperview().offset(-Constants.badgeSize / 4)
                $0.trailing.equalToSuperview().offset(Constants.badgeSize / 4)
                $0.size.equalTo(Constants.badgeSize)
            }
            
            container.clipsToBounds = false
            filesStack.addArrangedSubview(container)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapDelete() {
        deleteButton.animateTap(onCompletion: onDelete)
    }
}

