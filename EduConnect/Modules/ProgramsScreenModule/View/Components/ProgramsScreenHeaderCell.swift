//
//  ProgramsScreenHeaderCellViewModel.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.01.2026.
//

import UIKit
import SnapKit

struct ProgramsScreenHeaderCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "ProgramsScreenHeaderCell"
    let totalFields: Int
    let totalSpecializationsBachelor: Int
    let totalSpecializations: Int
    let totalEducationPrograms: Int
    
    init(totalFields: Int = 38, totalSpecializationsBachelor: Int = 109, totalSpecializations: Int = 38, totalEducationPrograms: Int = 1202) {
        self.totalFields = totalFields
        self.totalSpecializationsBachelor = totalSpecializationsBachelor
        self.totalSpecializations = totalSpecializations
        self.totalEducationPrograms = totalEducationPrograms
    }
}

final class ProgramsScreenHeaderCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let contentViewBackground = UIColor.hex("#795CED")
        static let imageWidth = 190.0
        static let imageHeight = 250.0
        
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProgramsScreenHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.programsScreenHeaderImage.image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.4
        return iv
    }()
    
    private let containerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск программ бакалавриата и специалитета в вузах по направлениям образования: "
        label.numberOfLines = 0
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let fieldsTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let bachelorTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let specializationsTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let programsTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private lazy var firstTotalsHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [fieldsTotalLabel, bachelorTotalLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var secondTotalsHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [specializationsTotalLabel, programsTotalLabel])
        stack.axis = .horizontal
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
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = Constants.contentViewBackground
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(Constants.imageWidth)
            $0.height.equalTo(Constants.imageHeight)
            $0.trailing.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(firstTotalsHStack)
        firstTotalsHStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(secondTotalsHStack)
        secondTotalsHStack.snp.makeConstraints {
            $0.top.equalTo(firstTotalsHStack.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? ProgramsScreenHeaderCellViewModel else { return }
        self.viewModel = vm
        self.fieldsTotalLabel.text = "\(vm.totalFields)\nнаправлений"
        self.bachelorTotalLabel.text = "\(vm.totalSpecializationsBachelor)\nспециальностей бакалавриата"
        self.specializationsTotalLabel.text = "\(vm.totalSpecializations)\nспециальностей специалитета"
        self.programsTotalLabel.text = "\(vm.totalEducationPrograms)\nпрограммы обучения"
    }
}
