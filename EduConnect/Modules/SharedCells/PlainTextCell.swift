//
//  PlainTextCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.03.2026.
//

import UIKit
import SnapKit

struct PlainTextCellViewModel {
    let text: String
    let textColor: UIColor
    let textFont: UIFont
    let textAlignment: NSTextAlignment
    let numberOfLines: Int
    let horizontallySpaced: Bool
    
    init(
        text: String,
        textColor: UIColor = .black,
        textFont: UIFont = ECFont.font(.medium, size: 16),
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 0,
        horizontallySpaced: Bool = false
    ) {
        self.text = text
        self.textColor = textColor
        self.textFont = textFont
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.horizontallySpaced = horizontallySpaced
    }
}

final class PlainTextCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: PlainTextCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private var textLabel: UILabel = UILabel()
    
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
    public func configure(withVM vm: PlainTextCellViewModel) {
        self.viewModel = vm
        textLabel.text = vm.text
        textLabel.textColor = vm.textColor
        textLabel.font = vm.textFont
        textLabel.textAlignment = vm.textAlignment
        textLabel.numberOfLines = vm.numberOfLines
        makeConstraints(horizontallySpaced: vm.horizontallySpaced)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeConstraints(horizontallySpaced: Bool) {
        textLabel.snp.remakeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(horizontallySpaced ? Constants.spacing : 0)
            $0.verticalEdges.equalToSuperview()
        }
    }
}
