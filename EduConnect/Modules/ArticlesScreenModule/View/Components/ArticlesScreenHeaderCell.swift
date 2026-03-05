//
//  ArticlesScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import UIKit
import SnapKit

struct ArticlesScreenHeaderCellViewModel { }

final class ArticlesScreenHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let contentViewBackground = UIColor.hex("#795CED")
        static let imageWidth = 240.0
        
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ArticlesScreenHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.articlesHeaderImage.image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.6
        return iv
    }()
    
    private let containerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Статьи"
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Навигатор поступления для абитуриентов вузов"
        label.font = ECFont.font(.regular, size: 16)
        label.textColor = .white
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
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = Constants.contentViewBackground
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.width.equalTo(Constants.imageWidth)
            $0.trailing.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: ArticlesScreenHeaderCellViewModel) {
        self.viewModel = vm
    }
}
