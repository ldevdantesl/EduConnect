//
//  AppliedUniversityCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct ApplicationCellViewModel {
    let application: Application
    let didTap: ((Application) -> Void)?
    
    init(application: Application, didTap: ((Application) -> Void)? = nil) {
        self.application = application
        self.didTap = didTap
    }
}

final class ApplicationCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // other
        static let containerCornerRadius = 20.0
        static let backgroundImageHeight = 160
        
        static let capIconWidth = 25.0
        static let capIconHeight = 20.0
        
        static let buttonHeight = 45.0
        static let buttonWidthRatio = 0.4
        
        // spacing
        static let spacing = 5.0
        static let midSpacing = 10.0
        static let semiBigSpacing = 15.0
        static let bigSpacing = 20.0
        static let semiHugeSpacing = 25.0
        static let hugeSpacing = 30.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ApplicationCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let imageOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = ECFont.font(.regular, size: 13)
        label.numberOfLines = 1
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = ECFont.font(.semiBold, size: 17)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = ECFont.font(.semiBold, size: 17)
        return label
    }()
    
    private let inReviewLabel: ECPaddedLabel = {
        let label = ECPaddedLabel()
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.font = ECFont.font(.bold, size: 14)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    private let statusNameLabel: ECPaddedLabel = {
        let label = ECPaddedLabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .white
        label.backgroundColor = .systemYellow
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSelf)))
        return view
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
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        
        applyFloatingShadow(cornerRadius: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.kf.cancelDownloadTask()
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(withVM vm: ApplicationCellViewModel) {
        self.viewModel = vm
        self.backgroundImage.kf.indicatorType = .activity
        self.backgroundImage.kf.setImage(
            with: URL(string: vm.application.university.logoURL),
            options: [
                .transition(.fade(0.25)),
                .cacheOriginalImage
            ]
        )
        self.locationLabel.text = "\(vm.application.university.city.name)"
        self.nameLabel.text = vm.application.university.name
        self.dateLabel.text = ECDateFormatter.formatISODate(vm.application.updatedAt)
        self.statusNameLabel.text = vm.application.statusName
        self.inReviewLabel.text = "На рассмотрении"
    }
    
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        self.clipsToBounds = false

        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }

        containerView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.backgroundImageHeight)
        }
        
        backgroundImage.addSubview(imageOverlayView)
        imageOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageOverlayView.addSubview(statusNameLabel)
        statusNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.midSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.midSpacing)
        }
        
        containerView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImage.snp.bottom).offset(Constants.semiBigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.semiBigSpacing)
        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalTo(locationLabel)
        }
        
        containerView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.semiBigSpacing)
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.semiBigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.semiBigSpacing)
        }
        
        containerView.addSubview(inReviewLabel)
        inReviewLabel.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.leading.equalToSuperview().offset(Constants.midSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.semiBigSpacing)
        }
    }
    
    // MARK: - OBJC
    @objc private func didTapSelf() {
        guard let application = viewModel?.application else { return }
        self.animateTap { [weak self] in
            self?.viewModel?.didTap?(application)
        }
    }
}
