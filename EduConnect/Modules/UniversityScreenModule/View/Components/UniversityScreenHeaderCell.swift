//
//  UniversityScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenHeaderCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "UniversityScreenHeaderCell"
}

final class UniversityScreenHeaderCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let contentViewBackground = UIColor.hex("#795CED")
        static let imageWidth = 240.0
        
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityScreenHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.universityScreenHeaderImage.image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.3
        return iv
    }()
    
    private let containerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вузы Казахстана:"
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "университеты, институты, академии"
        label.font = ECFont.font(.regular, size: 17)
        label.textColor = .white
        return label
    }()
    
    private let universitiesTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "1 143\nвуза"
        label.textColor = .white
        return label
    }()
    
    private let citiesTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "285\nгородов"
        label.textColor = .white
        return label
    }()
    
    private let budgetSpacesTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.text = "441 343\nбюджетных места"
        label.textColor = .white
        return label
    }()
    
    private lazy var totalsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [universitiesTotalLabel, citiesTotalLabel, budgetSpacesTotalLabel])
        stack.axis = .horizontal
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
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(totalsStack)
        totalsStack.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.lessThanOrEqualToSuperview().offset(-Constants.bigSpacing)
        }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? UniversityScreenHeaderCellViewModel else { return }
        self.viewModel = vm
    }
    
    // MARK: - OBJC FUNC
}
