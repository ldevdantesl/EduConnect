//
//  ECAttachedImageView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 11.03.2026.
//

import UIKit
import SnapKit

protocol ECImageAttachmentViewDelegate: AnyObject {
    func imageAttachmentViewDidTapAdd(_ view: ECImageAttachmentView)
    func imageAttachmentView(_ view: ECImageAttachmentView, didRemoveImage image: ECAttachedImage)
}

final class ECImageAttachmentView: UIView {
    
    fileprivate enum Constants {
        static let spacing = 10.0
        static let scrollViewHeight = 90.0
        static let cellSize = 80.0
    }
    
    weak var delegate: ECImageAttachmentViewDelegate?
    
    private(set) var images: [ECAttachedImage] = []
    var maxImages: Int = 5
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Common.noFileSelected
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let imagesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var addButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.browse, textSize: 16, backgroundColor: .systemBackground, textColor: .blue)
        button.borderColor = .blue
        button.borderWidth = 1
        button.setAction { [weak self] in
            guard let self else { return }
            self.delegate?.imageAttachmentViewDidTapAdd(self)
        }
        return button
    }()
    
    private var scrollViewHeightConstraint: Constraint?
    
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
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.systemGray4.cgColor
        addButton.layer.cornerRadius = 6
    }
    
    // MARK: - PUBLIC FUNC
    func addImage(_ image: ECAttachedImage) {
        guard images.count < maxImages else { return }
        images.append(image)
        
        let cell = ECSingleImageView(attachedImage: image) { [weak self] in
            self?.removeImage(image)
        }
        imagesStackView.addArrangedSubview(cell)
        updateUI()
    }
    
    func removeImage(_ image: ECAttachedImage) {
        images.removeAll { $0.id == image.id }
        
        imagesStackView.arrangedSubviews.forEach { view in
            if let cell = view as? ECSingleImageView, cell.attachedImage.id == image.id {
                cell.removeFromSuperview()
            }
        }
        
        delegate?.imageAttachmentView(self, didRemoveImage: image)
        updateUI()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.bottom)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        
        addSubview(scrollView)
        scrollView.addSubview(imagesStackView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            scrollViewHeightConstraint = $0.height.equalTo(0).constraint
        }
        
        imagesStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    private func updateUI() {
        titleLabel.text = (images.isEmpty ? ConstantLocalizedStrings.Common.noFileSelected : "\(images.count) \(ConstantLocalizedStrings.Common.files)") + " (\(ConstantLocalizedStrings.Common.max) \(maxImages))"
        addButton.isEnabled = images.count < maxImages
        
        let hasImages = !images.isEmpty
        scrollViewHeightConstraint?.update(offset: hasImages ? Constants.scrollViewHeight : 0)
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.superview?.layoutIfNeeded()
        }
    }
}
