//
//  CardWithImageCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct CardWithImageCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = CardWithImageCell.identifier
    let imageURL: String?
    let image: UIImage?
    let imageContentMode: UIImageView.ContentMode
    let preTitle: String?
    let title: String
    let subtitle: String?
    let showsArrowRight: Bool
    
    init(
        imageURL: String?, imageContentMode: UIImageView.ContentMode = .scaleAspectFill,
        preTitle: String? = nil, title: String, subtitle: String? = nil, showsArrowRight: Bool = false
    ) {
        self.imageURL = imageURL
        self.image = nil
        self.imageContentMode = imageContentMode
        self.title = title
        self.preTitle = preTitle
        self.subtitle = subtitle
        self.showsArrowRight = showsArrowRight
    }
    
    init(
        image: UIImage, imageContentMode: UIImageView.ContentMode = .scaleAspectFill,
        preTitle: String? = nil, title: String, subtitle: String? = nil, showsArrowRight: Bool = false
    ) {
        self.imageURL = nil
        self.image = image
        self.title = title
        self.imageContentMode = imageContentMode
        self.subtitle = subtitle
        self.preTitle = preTitle
        self.showsArrowRight = showsArrowRight
    }
}

final class CardWithImageCell: UICollectionViewCell, ConfigurableCellProtocol {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let smallSpacing = 6.0
        static let spacing = 12.0
        static let bigSpacing = 16.0
        static let cornerRadius = 16.0
        static let imageInset = 12.0
        static let imageCornerRadius = 12.0
        static let imageHeight = 200.0
        static let arrowImageSize = 25.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: CardWithImageCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.layer.cornerRadius = Constants.imageCornerRadius
        iv.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return iv
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
        applyShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        subtitleLabel.isHidden = false
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? CardWithImageCellViewModel else { return }
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
        
        cardImageView.contentMode = vm.imageContentMode
        if let image = vm.image {
            cardImageView.image = image
        } else if let urlString = vm.imageURL, let url = URL(string: urlString) {
            cardImageView.kf.setImage(
                with: url,
                placeholder: ImageConstants.appLogo.image,
                options: [.transition(.fade(0.2))]
            )
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
        
        containerView.addSubview(cardImageView)
        cardImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.imageHeight)
        }
        
        containerView.addSubview(pretitleLabel)
        pretitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(pretitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(arrowRightImage)
        arrowRightImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.arrowImageSize)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
    
    private func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
        layer.masksToBounds = false
    }
    
    // MARK: - OBJC FUNC
    @objc private func tapAction() {
        animateTap()
    }
}
