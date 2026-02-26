//
//  PageIndicatorCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import UIKit
import SnapKit

struct PageIndicatorCellViewModel {
    var totalPages: Int = 1
    var currentPage: Int = 1
    var didPressNextPage: (() -> Void)?
    var didPressPage: ((Int) -> Void)?
}

final class PageIndicatorCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: PageIndicatorCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var nextPageLabel: UILabel = {
        let label = UILabel()
        label.text = "Next"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapNextPage)))
        label.font = ECFont.font(.medium, size: 16)
        return label
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.isUserInteractionEnabled = true
        stack.distribution = .fill
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
    func configure(withVM vm: PageIndicatorCellViewModel) {
        self.viewModel = vm
        makeStacK()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    private func makeStacK() {
        guard let viewModel, viewModel.totalPages > 0 else { return }
        hStack.arrangedSubviews.forEach { $0.removeFromSuperview(); hStack.removeArrangedSubview($0) }
        
        let leadingSpacer = UIView()
        leadingSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        leadingSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        hStack.addArrangedSubview(leadingSpacer)
        let lastPage = min(5, viewModel.totalPages)
        
        for page in 1...lastPage {
            let label = ECPaddedLabel()
            label.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            label.text = "\(page)"
            label.font = ECFont.font(.medium, size: 16)
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.tag = page
            hStack.addArrangedSubview(label)
            
            if page == viewModel.currentPage {
                label.textColor = .white
                label.font = ECFont.font(.semiBold, size: 17)
                label.backgroundColor = .systemBlue
                label.clipsToBounds = true
                label.makeCircular = true
            } else {
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapPage(_:))))
            }
        }
        
        if hStack.arrangedSubviews.count > 2 && lastPage > viewModel.currentPage {
            nextPageLabel.setContentHuggingPriority(.required, for: .horizontal)
            hStack.addArrangedSubview(nextPageLabel)
        }
        
        let trailingSpacer = UIView()
        trailingSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trailingSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        hStack.addArrangedSubview(trailingSpacer)
        
        leadingSpacer.snp.makeConstraints {
            $0.width.equalTo(trailingSpacer)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapPage(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view as? UILabel else { return }
        let page = view.tag
        self.viewModel?.didPressPage?(page)
    }
    
    @objc private func didTapNextPage() {
        self.viewModel?.didPressNextPage?()
    }
}
