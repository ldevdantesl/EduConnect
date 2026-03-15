//
//  ProgramDetailsUniversityCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.03.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct ProgramDetailsUniversityCardCellViewModel {
    let university: ECUniversity
    var didTapUniversity: ((Int) -> Void)? = nil
}

final class ProgramDetailsUniversityCardCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let imageSize = 80.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProgramDetailsUniversityCardCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContainer)))
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.systemGray6
        view.applyFloatingShadow()
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let pretitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = ECFont.font(.semiBold, size: 18)
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
    public func configure(withVM vm: ProgramDetailsUniversityCardCellViewModel) {
        self.viewModel = vm
        self.nameLabel.text = vm.university.name
        self.pretitleLabel.text = vm.university.city.name
        
        guard let url = URL(string: vm.university.logoURL ?? "") else {
            imageView.image = ImageConstants.SystemImages.questionMark.image
            return
        }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: ImageConstants.appLogo.image)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.size.equalTo(Constants.imageSize)
        }
        
        containerView.addSubview(pretitleLabel)
        pretitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(pretitleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
    
    // MARK: - OBJC PRIVATE FUNC
    @objc private func didTapContainer() {
        guard let vm = viewModel else { return }
        containerView.animateTap {
            vm.didTapUniversity?(vm.university.id)
        }
    }
}
