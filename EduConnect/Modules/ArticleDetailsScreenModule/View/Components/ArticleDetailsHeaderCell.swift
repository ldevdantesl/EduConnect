//
//  ArticleDetailsHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.03.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct ArticleDetailsHeaderCellViewModel {
    let article: ECNews
}

final class ArticleDetailsHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ArticleDetailsHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    
    private let pretitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 14)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
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
    public func configure(withVM vm: ArticleDetailsHeaderCellViewModel) {
        self.viewModel = vm
        pretitleLabel.text = ECDateFormatter.formatISODate(vm.article.createdAt)
        titleLabel.text = vm.article.title.ru
        subtitleLabel.text = vm.article.shortDescription.ru
        
        guard let url = URL(string: vm.article.previewImageURL) else {
            headerImageView.image = ImageConstants.appLogo.image
            return
        }
        headerImageView.kf.indicatorType = .activity
        headerImageView.kf.setImage(with: url, placeholder: ImageConstants.appLogo.image)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(headerImageView.snp.width).multipliedBy(0.6)
            $0.bottom.equalToSuperview()
        }
        
        headerImageView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(pretitleLabel)
        pretitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.lessThanOrEqualToSuperview().offset(-Constants.bigSpacing)
        }
    }
}
