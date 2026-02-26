//
//  MainScreenApplyUniversityItem.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct MainScreenCareersItemViewModel {
    let university: ECUniversity
    let onTapAction: ((ECUniversity) -> Void)?
    
    init(university: ECUniversity, onTapAction: ((ECUniversity) -> Void)? = nil) {
        self.university = university
        self.onTapAction = onTapAction
    }
}

final class MainScreenCareersItem: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenCareersItemViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        return iv
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(Constants.spacing * 2) }
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAction)))
        return view
    }()
    
    private let universityNameLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 18)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageContainer.layer.cornerRadius = 30
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenCareersItemViewModel) {
        self.viewModel = vm
        universityNameLabel.text = vm.university.name
        guard let url = URL(string: vm.university.logoURL ?? "") else { return }
        imageView.kf.setImage(with: url, placeholder: ImageConstants.SystemImages.questionMark.image)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(imageContainer)
        imageContainer.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        contentView.addSubview(universityNameLabel)
        universityNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageContainer.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - OBJC
    @objc private func didTapAction() {
        self.animateTap { [weak self] in
            guard let self = self, let viewModel = self.viewModel else { return }
            viewModel.onTapAction?(viewModel.university)
        }
    }
}
