//
//  HomeScreenUniversityCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import UIKit
import SnapKit

struct HomeScreenUniversityCellViewModel: CellViewModel {
    var cellIdentifier: String = "HomeScreenUniversityCell"
    let university: ECUniversity
}

final class HomeScreenUniversityCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        // other
        static let containerCornerRadius = 20.0
        static let backgroundImageHeightRatio = 0.4
        
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
    private var viewModel: HomeScreenUniversityCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:ImageConstants.universityImageSample)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let locationAndOwnershipLabel: UILabel = {
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
    
    private let fieldsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.textAlignment = .left
        label.font = ECFont.font(.regular, size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = ECFont.font(.semiBold, size: 17)
        return label
    }()
    
    private let universityCapIconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageConstants.universityCapIconImage)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let universityAdmissionInfo: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 15)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let programsButton: ECButton = ECButton()
    
    private let facultyButton: ECUnderlineButton = ECUnderlineButton()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 20
        layer.shadowOffset = CGSize(width: 0, height: 8)

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constants.containerCornerRadius
        ).cgPath
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.layoutContainerView()
        self.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        self.clipsToBounds = false
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func validatedFieldsText(fields: [String]) -> String {
        guard fields.count > 1 else { return fields.joined(separator: ";") }
        return "\(fields[0]); \(fields[1]) и ещё 8 направлений"
    }
    
    private func layoutContainerView() {
        containerView.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(Constants.backgroundImageHeightRatio)
        }
        
        backgroundImage.addSubview(universityCapIconImage)
        universityCapIconImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.leading.equalToSuperview().offset(Constants.bigSpacing)
            $0.width.equalTo(Constants.capIconWidth)
            $0.height.equalTo(Constants.capIconHeight)
        }
        
        backgroundImage.addSubview(universityAdmissionInfo)
        universityAdmissionInfo.snp.makeConstraints {
            $0.top.equalTo(universityCapIconImage.snp.bottom).offset(Constants.semiBigSpacing)
            $0.leading.equalTo(universityCapIconImage.snp.leading)
            $0.trailing.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(locationAndOwnershipLabel)
        locationAndOwnershipLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImage.snp.bottom).offset(Constants.semiBigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.semiBigSpacing)
        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(locationAndOwnershipLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalTo(locationAndOwnershipLabel)
        }
        
        containerView.addSubview(fieldsLabel)
        fieldsLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.midSpacing)
            $0.horizontalEdges.equalTo(locationAndOwnershipLabel)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(fieldsLabel.snp.bottom).offset(Constants.midSpacing)
            $0.horizontalEdges.equalTo(locationAndOwnershipLabel)
        }
        
        containerView.addSubview(programsButton)
        programsButton.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.leading.equalTo(Constants.semiBigSpacing)
            $0.width.equalToSuperview().multipliedBy(Constants.buttonWidthRatio)
            $0.height.equalTo(Constants.buttonHeight)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
        
        containerView.addSubview(facultyButton)
        facultyButton.snp.makeConstraints {
            $0.bottom.equalTo(programsButton.snp.bottom).offset(-Constants.midSpacing)
            $0.leading.lessThanOrEqualTo(programsButton.snp.trailing).offset(Constants.hugeSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.hugeSpacing)
        }
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(withVM vm: any CellViewModel) {
        guard let vm = vm as? HomeScreenUniversityCellViewModel else { return }
        self.viewModel = vm
        self.locationAndOwnershipLabel.text = "\(vm.university.location) / \(vm.university.ownerShip.rawValue)"
        self.nameLabel.text = vm.university.name
        self.priceLabel.text = "от \(vm.university.price) / год"
        self.universityAdmissionInfo.text = """
        от \(vm.university.admissionInfo.budget.minScore) бал.бюджет
        от \(vm.university.admissionInfo.paid.minScore) бал.платно
        \(vm.university.admissionInfo.budget.seats) места бюджет
        \(vm.university.admissionInfo.paid.seats) места платно
        """
        self.fieldsLabel.text = validatedFieldsText(fields: vm.university.fields)
        self.programsButton.configure(text: "\(vm.university.programs) программ")
        self.facultyButton.configure(text: "\(vm.university.faculties) факультета")
    }
}
