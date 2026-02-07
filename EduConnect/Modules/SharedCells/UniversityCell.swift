//
//  HomeScreenUniversityCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct UniversityCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "UniversityCell"
    let university: ECUniversity
    let horizontallySpaced: Bool
    let didTap: ((ECUniversity) -> Void)?
    
    init(university: ECUniversity, horizontallySpaced: Bool = false, didTap: ((ECUniversity) -> Void)? = nil) {
        self.university = university
        self.horizontallySpaced = horizontallySpaced
        self.didTap = didTap
    }
}

final class UniversityCell: UICollectionViewCell, ConfigurableCellProtocol {
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
    private var viewModel: UniversityCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let imageOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isUserInteractionEnabled = false
        return view
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
    
    private let professionsLabel: UILabel = {
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
        image.image = ImageConstants.capIcon.image
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let universityAdmissionInfo: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 16)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let programsButton: ECButton = ECButton()
    
    private let facultyButton: ECUnderlineButton = ECUnderlineButton()
    
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
        backgroundImage.image = nil
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.layer.masksToBounds = false
        self.contentView.clipsToBounds = false
        self.clipsToBounds = false
        self.contentView.addSubview(containerView)
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
        
        imageOverlayView.addSubview(universityCapIconImage)
        universityCapIconImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.leading.equalToSuperview().offset(Constants.bigSpacing)
            $0.width.equalTo(Constants.capIconWidth)
            $0.height.equalTo(Constants.capIconHeight)
        }
        
        imageOverlayView.addSubview(universityAdmissionInfo)
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
        
        containerView.addSubview(professionsLabel)
        professionsLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.midSpacing)
            $0.horizontalEdges.equalTo(locationAndOwnershipLabel)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(professionsLabel.snp.bottom).offset(Constants.midSpacing)
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
        layoutIfNeeded()
    }
    
    private func validatedProfessionsText(professions: [ECUniversity.ImagedEntity]) -> String {
        let professionNames = professions.map { $0.name }
        guard professionNames.count > 2 else { return professionNames.joined(separator: ";") }
        return "\(professionNames[0]); \(professionNames[1]) и ещё \(professionNames.count - 2) направлений"
    }
    
    private func decoratedAdmissionInfoText(_ text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4

        return NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white,
                .font: ECFont.font(.bold, size: 16)
            ]
        )
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset((viewModel?.horizontallySpaced ?? false) ? Constants.midSpacing : 0)
        }
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? UniversityCellViewModel else { return }
        self.viewModel = vm
        self.backgroundImage.kf.indicatorType = .activity
        if let indicator = backgroundImage.kf.indicator as? UIActivityIndicatorView {
            indicator.color = .systemPurple
        }
        self.backgroundImage.kf.setImage(
            with: URL(string: vm.university.mainImageURL),
            options: [
                .transition(.fade(0.25)),
                .cacheOriginalImage
            ]
        )
        self.locationAndOwnershipLabel.text = "\(vm.university.city.name) / \(vm.university.universityTypeName)"
        self.nameLabel.text = vm.university.name
        self.priceLabel.text = "от \(ECNumberFormatter.toDecimalFromString(number: vm.university.minContractPrice))₸ / год"
        let admissionText = """
        от \(ECNumberFormatter.toDecimalFromString(number: vm.university.minContractPrice)) бал бюджет
        от \(ECNumberFormatter.toDecimalFromString(number: vm.university.minContractPrice)) бал платно
        \(vm.university.budgetPlaces) места бюджет
        \(vm.university.paidPlaces) места платно
        """
        self.universityAdmissionInfo.attributedText = decoratedAdmissionInfoText(admissionText)
        
        self.professionsLabel.text = validatedProfessionsText(professions: vm.university.professions)
        self.programsButton.configure(text: "\(vm.university.programsCount) программ")
        self.facultyButton.configure(text: "\(vm.university.facultiesCount) факультета")
        
        makeConstraints()
    }
    
    // MARK: - OBJC
    @objc private func didTapSelf() {
        guard let university = viewModel?.university else { return }
        viewModel?.didTap?(university)
    }
}
