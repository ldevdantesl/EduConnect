//
//  ECAttachmentView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit
import SnapKit
import UniformTypeIdentifiers

protocol ECFileAttachmentViewDelegate: AnyObject {
    func fileAttachmentViewDidTapAdd(_ view: ECFileAttachmentView)
    func fileAttachmentView(_ view: ECFileAttachmentView, didRemoveFile file: ECAttachedFile)
}

final class ECFileAttachmentView: UIView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let scrollViewHeight = 80.0
    }
    
    // MARK: - DELEGATE
    weak var delegate: ECFileAttachmentViewDelegate?
    
    // MARK: - PROPERTIES
    private(set) var files: [ECAttachedFile] = []
    
    var maxFiles: Int = 5
    var allowedTypes: [UTType] = [.pdf, .image, .png, .jpeg]
    var cellsWidth = 120.0
    
    // MARK: - VIEW PROPERTIES
    private let noFileLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Common.noFileSelected
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let filesStackView: UIStackView = {
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

    private lazy var browseButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.browse, textSize: 14, backgroundColor: .systemBackground, textColor: .blue)
        button.borderColor = .blue
        button.borderWidth = 1
        button.setAction { [weak self] in self?.browseButtonTapped() }
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
        browseButton.layer.borderWidth = 1
        browseButton.layer.borderColor = UIColor.systemGray4.cgColor
        browseButton.layer.cornerRadius = 6
    }
    
    // MARK: - PUBLIC FUNC
    public func addFile(_ file: ECAttachedFile) {
        guard files.count < maxFiles else { return }
        files.append(file)
        
        let vm = ECSingleFileViewModel(file: file) { [weak self] in
            guard let self = self else { return }
            self.removeFile(file)
        }
        let fileCell = ECSingleFileView(viewModel: vm)
        fileCell.fixedWidth = cellsWidth
        filesStackView.addArrangedSubview(fileCell)
        
        updateUI()
    }
    
    public func removeFile(_ file: ECAttachedFile) {
        files.removeAll { $0.id == file.id }
        
        filesStackView.arrangedSubviews.forEach { view in
            if let cell = view as? ECSingleFileView, cell.viewModel.file.id == file.id {
                cell.removeFromSuperview()
            }
        }
        
        delegate?.fileAttachmentView(self, didRemoveFile: file)
        updateUI()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        addSubview(noFileLabel)
        noFileLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        addSubview(browseButton)
        browseButton.snp.makeConstraints {
            $0.bottom.equalTo(noFileLabel.snp.bottom)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        
        addSubview(scrollView)
        scrollView.addSubview(filesStackView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(noFileLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            scrollViewHeightConstraint = $0.height.equalTo(0).constraint
        }
        
        filesStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    private func updateUI() {
        noFileLabel.text = (files.isEmpty ? ConstantLocalizedStrings.Common.noFileSelected : "\(files.count) \(ConstantLocalizedStrings.Common.files)") + "(\(ConstantLocalizedStrings.Common.max) \(maxFiles))"
        browseButton.isEnabled = files.count < maxFiles
        
        let hasFiles = !files.isEmpty
        scrollViewHeightConstraint?.update(offset: hasFiles ? Constants.scrollViewHeight : 0)
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.superview?.layoutIfNeeded()
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func browseButtonTapped() {
        delegate?.fileAttachmentViewDidTapAdd(self)
    }
}
