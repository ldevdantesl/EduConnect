//
//  UniversityInfoScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 30.01.2026.
//

import UIKit
import SnapKit

struct UniversityInfoScreenHeaderCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = UniversityInfoScreenHeaderCell.identifier
    let university: ECUniversity
}

final class UniversityInfoScreenHeaderCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
        static let imageSize = 24.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityInfoScreenHeaderCellViewModel?

    // MARK: - VIEW PROPERTIES
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let programsLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.hex("#DFD7FF")
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let minPriceLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.hex("#DFD7FF")
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let budgetPlacesLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.hex("#DFD7FF")
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let paidPlacesLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.hex("#DFD7FF")
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let advantagesImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.universityAdvantageCheckmarkIcon.image
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let advantagesLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.hex("#DFD7FF")
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private lazy var advantagesVStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [advantagesImageView, advantagesLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    
    private lazy var firstHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [programsLabel, minPriceLabel, budgetPlacesLabel])
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var secondHStack: UIStackView = {
        let trailingSpacer = UIView()
        trailingSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trailingSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let stack = UIStackView(arrangedSubviews: [paidPlacesLabel, advantagesVStack, trailingSpacer])
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .top
        stack.distribution = .fill
        return stack
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
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? UniversityInfoScreenHeaderCellViewModel else { return }
        self.viewModel = vm
        nameLabel.text = "\(vm.university.name)"
        programsLabel.text = "\(vm.university.programsCount)\nпрограмм"
        minPriceLabel.text = "от \(ECNumberFormatter.toDecimalFromString(number: vm.university.minContractPrice))\nтенге в год"
        budgetPlacesLabel.text = "\(vm.university.budgetPlaces)\nбюджет. мест"
        paidPlacesLabel.text = "\(vm.university.paidPlaces)\nплатных. мест"
        var advantagesText: String = "\(vm.university.universityTypeName.capitalized)"
        vm.university.hasDormitory ? advantagesText.append(", Общежитие") : ()
        vm.university.hasMilitaryDepartment ? advantagesText.append(", Воен. уч.") : ()
        self.advantagesLabel.text = advantagesText
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = .systemBlue
            
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
    
        contentView.addSubview(firstHStack)
        firstHStack.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        contentView.addSubview(secondHStack)
        secondHStack.snp.makeConstraints {
            $0.top.equalTo(firstHStack.snp.bottom).offset(Constants.hSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.hSpacing)
        }
        
        advantagesImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.imageSize)
        }
    }
}
