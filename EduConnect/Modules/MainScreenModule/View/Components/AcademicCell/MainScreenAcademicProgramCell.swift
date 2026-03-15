//
//  MainScreenAcademicProgramCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct MainScreenAcademicProgramCellViewModel {
    let program: ECProgramCategory
    let didTapProgram: ((ECProgramCategory) -> Void)?
    
    init(program: ECProgramCategory, didTapProgram: ((ECProgramCategory) -> Void)? = nil) {
        self.program = program
        self.didTapProgram = didTapProgram
    }
}

final class MainScreenAcademicProgramCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let imageSize = 30.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenAcademicProgramCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let dashedView: ECDashedBorderView = {
        let view = ECDashedBorderView()
        view.cornerRadius = 30.0
        view.contentView.backgroundColor = .white
        view.showShadow = true
        return view
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 18)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel])
        imageView.snp.makeConstraints { $0.size.equalTo(Constants.imageSize) }
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private let programsLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let budgetPlaces: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let paidPlaces: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [programsLabel, budgetPlaces, paidPlaces])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 10
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
    func configure(withVM vm: MainScreenAcademicProgramCellViewModel) {
        self.viewModel = vm
        if let url = URL(string: vm.program.iconURL ?? "") {
            self.imageView.kf.setImage(with: url, placeholder: ImageConstants.appLogo.image)
        } else {
            self.imageView.image = ImageConstants.appLogo.image
        }
        
        nameLabel.text = vm.program.name.toCurrentLanguage()
        programsLabel.text = "\(vm.program.programsCount ?? 0) Программ"
        budgetPlaces.text = "34 Бюджетных мест"
        paidPlaces.text = "31 Платных мест"
        
        dashedView.setAction {
            vm.didTapProgram?(vm.program)
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(dashedView)
        dashedView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.spacing)
        }
        
        dashedView.contentView.addSubview(titleStack)
        titleStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        dashedView.contentView.addSubview(descriptionStack)
        descriptionStack.snp.makeConstraints {
            $0.top.equalTo(titleStack.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing * 3)
        }
    }
}
