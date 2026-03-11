//
//  ECSingleImageView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 11.03.2026.
//

import UIKit
import SnapKit

// MARK: - ECSingleImageView
final class ECSingleImageView: UIView {
    
    fileprivate enum Constants {
        static let size = 80.0
        static let cornerRadius = 10.0
        static let removeButtonSize = 22.0
    }
    
    let attachedImage: ECAttachedImage
    private let onRemove: (() -> Void)?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = Constants.cornerRadius
        return iv
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(ImageConstants.SystemImages.xmarkCircle.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.layer.cornerRadius = Constants.removeButtonSize / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
        return button
    }()
    
    init(attachedImage: ECAttachedImage, onRemove: (() -> Void)?) {
        self.attachedImage = attachedImage
        self.onRemove = onRemove
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.image = attachedImage.image
        
        addSubview(imageView)
        addSubview(removeButton)
        
        self.snp.makeConstraints {
            $0.width.height.equalTo(Constants.size).priority(.high)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(4)
            $0.size.equalTo(Constants.removeButtonSize)
        }
    }
    
    @objc private func removeTapped() {
        onRemove?()
    }
}
