//
//  ECFileView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit
import SnapKit
import UniformTypeIdentifiers

struct ECSingleFileViewModel {
    let file: ECAttachedFile
    let onRemove: (() -> Void)?
    
    init(file: ECAttachedFile, onRemove: (() -> Void)? = nil) {
        self.file = file
        self.onRemove = onRemove
    }
}

final class ECSingleFileView: UIView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let xmarkButtonImage = UIImage(systemName:"xmark.circle.fill")
        static let photoImage = UIImage(systemName: "photo")
        static let pdfImage = UIImage(systemName: "doc.fill")
        static let paperclipImage = UIImage(systemName: "paperclip")
        
        static let buttonSize = 24.0
        static let spacing = 10.0
        static let cornerRadius = 10.0
    }
    
    // MARK: - PROPERTIES
    let viewModel: ECSingleFileViewModel
    private var widthConstraint: Constraint?
    var fixedWidth: CGFloat = 120.0 { didSet { widthConstraint?.update(offset: fixedWidth) } }
    
    // MARK: - VIEW PROPERTIES
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemBlue
        iv.image = iconForFile()
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 14)
        label.text = viewModel.file.name
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 12)
        label.text = viewModel.file.formattedSize
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.xmarkButtonImage, for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: ECSingleFileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = Constants.cornerRadius
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        backgroundColor = .secondarySystemBackground
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(sizeLabel)
        addSubview(removeButton)
        
        self.snp.makeConstraints {
            widthConstraint = $0.width.equalTo(fixedWidth).constraint
        }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.buttonSize)
        }
        
        removeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.buttonSize)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(Constants.spacing)
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.trailing.equalTo(removeButton.snp.leading).offset(-Constants.spacing)
        }
        
        sizeLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
    
    private func iconForFile() -> UIImage? {
        if viewModel.file.type?.conforms(to: .image) == true {
            return Constants.photoImage
        } else if viewModel.file.type?.conforms(to: .pdf) == true {
            return Constants.pdfImage
        }
        return Constants.paperclipImage
    }
    
    // MARK: - OBJC FUNC
    @objc private func removeTapped() {
        viewModel.onRemove?()
    }
}
