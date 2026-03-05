//
//  CardCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import UIKit
import SnapKit

struct CardCellViewModel {
    let preTitle: String?
    let title: String
    let subtitle: String?
    let showsArrowRight: Bool
    let didTap: (() -> Void)?
    
    init(preTitle: String? = nil, title: String, subtitle: String? = nil, showsArrowRight: Bool = false, didTap: (() -> Void)? = nil) {
        self.title = title
        self.preTitle = preTitle
        self.subtitle = subtitle
        self.showsArrowRight = showsArrowRight
        self.didTap = didTap
    }
}

final class CardCell: UICollectionViewCell {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let smallSpacing = 6.0
        static let spacing = 12.0
        static let bigSpacing = 16.0
        static let cornerRadius = 25.0
        static let imageInset = 12.0
        static let imageCornerRadius = 12.0
        static let imageHeight = 200.0
        static let arrowImageSize = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: CardCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        return view
    }()
    
    private let pretitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 18)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let arrowRightImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageConstants.arrowRightIcon.image
        image.contentMode = .scaleAspectFit
        return image
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyFloatingShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        subtitleLabel.isHidden = false
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: CardCellViewModel) {
        self.viewModel = vm
        
        if let preTitle = vm.preTitle {
            pretitleLabel.text = preTitle
            pretitleLabel.isHidden = false
        } else {
            pretitleLabel.isHidden = true
        }
        
        titleLabel.text = vm.title
        
        if let subtitle = vm.subtitle, !subtitle.isEmpty {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        } else {
            subtitleLabel.isHidden = true
        }
        
        arrowRightImage.isHidden = !vm.showsArrowRight
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.verticalEdges.equalToSuperview()
        }
        
        containerView.addSubview(pretitleLabel)
        pretitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(arrowRightImage)
        arrowRightImage.snp.makeConstraints {
            $0.top.equalTo(pretitleLabel.snp.bottom).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.arrowImageSize)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(pretitleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview().inset(Constants.bigSpacing)
            $0.trailing.equalTo(arrowRightImage.snp.leading)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func tapAction() {
        guard let vm = viewModel else { return }
        animateTap(onCompletion: vm.didTap)
    }
}
