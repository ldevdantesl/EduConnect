//
//  HeaderWithSubtitleCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import UIKit
import SnapKit

struct HeaderWithSubtitleCellViewModel {
    let title: String
    let titleSize: CGFloat
    let titleColor: UIColor
    
    let subtitle: String
    let subtitleSize: CGFloat
    let subtitleColor: UIColor

    init(
        title: String, titleSize: CGFloat = 20,
        titleColor: UIColor = .black, subtitle: String,
        subtitleSize: CGFloat = 16, subtitleColor: UIColor = .gray
    ) {
        self.title = title
        self.titleColor = titleColor
        self.titleSize = titleSize
        
        self.subtitle = subtitle
        self.subtitleSize = subtitleSize
        self.subtitleColor = subtitleColor
    }
}

final class HeaderWithSubtitleCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: HeaderWithSubtitleCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
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
    func configure(withVM vm: HeaderWithSubtitleCellViewModel) {
        self.viewModel = vm
        titleLabel.text = vm.title
        titleLabel.textColor = vm.titleColor
        titleLabel.font = ECFont.font(.bold, size: vm.titleSize)
        subtitleLabel.text = vm.subtitle
        subtitleLabel.textColor = vm.subtitleColor
        subtitleLabel.font = ECFont.font(.regular, size: vm.subtitleSize)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
