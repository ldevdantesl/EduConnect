//
//  ProfessionScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.02.2026.
//

import UIKit
import SnapKit

struct ProfessionScreenHeaderCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = ProfessionScreenHeaderCell.identifier
    init() { }
}

final class ProfessionScreenHeaderCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let contentViewBackground = UIColor.hex("#795CED")
        static let imageWidth = 240.0
        
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionScreenHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.professionScreenImage.image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.4
        return iv
    }()
    
    private let containerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Профессии"
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Полный каталог профессий от A до Я"
        label.font = ECFont.font(.regular, size: 17)
        label.textColor = .white
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
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? ProfessionScreenHeaderCellViewModel else { return }
        self.viewModel = vm
    }
}
