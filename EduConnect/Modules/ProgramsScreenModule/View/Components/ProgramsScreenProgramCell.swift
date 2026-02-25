//
//  ProgramsScreenProgramCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.01.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct ProgramsScreenProgramCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "ProgramsScreenProgramCell"
    let programTitle: String
    var programImageURL: String?
    
    init(programTitle: String, programImageURL: String? = nil) {
        self.programTitle = programTitle
        self.programImageURL = programImageURL
    }
}

final class ProgramsScreenProgramCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let smallSpacing = 5.0
        static let cornerRadius = 24.0
        static let imageSize = 35
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProgramsScreenProgramCellViewModel?
    private lazy var dasherBorderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = nil
        layer.lineDashPattern = [8, 6]
        layer.lineWidth = 2
        return layer
    }()
    
    // MARK: - VIEW PROPERTIES
    private let programImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .systemBlue
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let programTitleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 6)
        view.layer.shadowRadius = 16
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [programImageView, programTitleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.clipsToBounds = true
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.programTitleLabel.text = nil
        self.programImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dasherBorderLayer.path = UIBezierPath(
            roundedRect: contentView.bounds.insetBy(dx: 1, dy: 1),
            cornerRadius: Constants.cornerRadius
        ).cgPath
        dasherBorderLayer.frame = contentView.bounds
        
        vStack.layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? ProgramsScreenProgramCellViewModel else { return }
        self.viewModel = vm
        self.programTitleLabel.text = vm.programTitle
        if let urlString = vm.programImageURL,
           let url = URL(string: urlString) {
            programImageView.kf.setImage(with: url)
        } else {
            programImageView.image = ImageConstants.SystemImages.questionMark.image
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.layer.addSublayer(dasherBorderLayer)
        
        contentView.addSubview(shadowContainerView)
        shadowContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.smallSpacing)
        }
        
        shadowContainerView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing * 2)
        }
        
        programImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.imageSize)
        }
    }
}
