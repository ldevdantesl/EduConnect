//
//  UniversityInfoScreenContactsCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

struct UniversityInfoScreenContactsCellViewModel {
    let university: ECUniversity
    let applied: Bool
    let didTapApply: (() -> Void)?
    let didTapRemove: (() -> Void)?
    
    init(university: ECUniversity, applied: Bool, didTapApply: (() -> Void)? = nil, didTapRemove: (() -> Void)? = nil) {
        self.applied = applied
        self.university = university
        self.didTapApply = didTapApply
        self.didTapRemove = didTapRemove
    }
}

final class UniversityInfoScreenContactsCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let imageSize = 30.0
        static let spacing = 20.0
        static let buttonCornerRadius = 30.0
        static let vSpacing = 10.0
        static let buttonHeight = 120
        static let buttonImage = "chevron.right"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityInfoScreenContactsCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Контакты"
        label.font = ECFont.font(.bold, size: 20)
        label.textColor = .label
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 18)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private lazy var phoneStackView: UIStackView = {
        let image = UIImageView()
        image.image = ImageConstants.phoneIcon.image
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { $0.size.equalTo(Constants.imageSize) }
        
        let stack = UIStackView(arrangedSubviews: [image, phoneLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let mailsLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 18)
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private lazy var mailStackView: UIStackView = {
        let image = UIImageView()
        image.image = ImageConstants.emailIcon.image
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { $0.size.equalTo(Constants.imageSize) }
        
        let stack = UIStackView(arrangedSubviews: [image, mailsLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 18)
        label.numberOfLines = 1
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let image = UIImageView()
        image.image = ImageConstants.geopositionIcon.image
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { $0.size.equalTo(Constants.imageSize) }
        
        let stack = UIStackView(arrangedSubviews: [image, locationLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private let chooseUniversityLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.numberOfLines = 3
        label.textColor = .white
        return label
    }()

    private lazy var chooseUniversityButton: UIView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: Constants.buttonImage)
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        
        let view = UIView()
        view.addSubview(chooseUniversityLabel)
        chooseUniversityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        view.addSubview(iv)
        iv.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        view.backgroundColor = .systemBlue
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
        chooseUniversityButton.layer.cornerRadius = Constants.buttonCornerRadius
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: UniversityInfoScreenContactsCellViewModel) {
        self.viewModel = vm
        self.phoneLabel.text = vm.university.phone
        self.mailsLabel.text = vm.university.email
        self.locationLabel.text = vm.university.address
        configureButton(applied: vm.applied)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(phoneStackView)
        phoneStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(mailStackView)
        mailStackView.snp.makeConstraints {
            $0.top.equalTo(phoneStackView.snp.bottom).offset(Constants.vSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(locationStackView)
        locationStackView.snp.makeConstraints {
            $0.top.equalTo(mailStackView.snp.bottom).offset(Constants.vSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(chooseUniversityButton)
        chooseUniversityButton.snp.makeConstraints {
            $0.top.equalTo(locationStackView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.height.equalTo(Constants.buttonHeight)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
    
    private func configureButton(applied: Bool) {
        if applied {
            chooseUniversityLabel.text = "Удалить\nнынешнюю\nзаявку"
            chooseUniversityButton.backgroundColor = .systemRed
        } else {
            chooseUniversityLabel.text = "Выбрать\nвуз для\nпоступления"
            chooseUniversityButton.backgroundColor = .systemBlue
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTap() {
        guard let viewModel else { return }
        self.chooseUniversityButton.animateTap {
            viewModel.applied ?
            viewModel.didTapRemove?() : viewModel.didTapApply?()
        }
    }
}
