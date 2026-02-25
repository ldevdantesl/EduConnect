//
//  MainScreenProgramsCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct MainScreenProgramsCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = MainScreenProgramsCell.identifier
    let programs: [ECProgramCategory]
    var didTapProgram: ((ECProgramCategory) -> Void)?
    var didTapShowAll: (() -> Void)?
    
    init(programs: [ECProgramCategory], didTapProgram: ((ECProgramCategory) -> Void)? = nil, didTapShowAll: (() -> Void)? = nil) {
        self.programs = programs
        self.didTapProgram = didTapProgram
        self.didTapShowAll = didTapShowAll
    }
}

final class MainScreenProgramsCell: UICollectionViewCell, ConfigurableCellProtocol {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let itemSpacing = 12.0
        static let maxVisiblePrograms = 3
        static let chevronRightImage = "chevron.right"
        static let imageSize = 25
        static let programImageSize = 40.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenProgramsCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let text = "Направления высшего\nобразования в Казахстане"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [.font: ECFont.font(.bold, size: 24)]
        )
        if let range = text.range(of: "в Казахстане") {
            let nsRange = NSRange(range, in: text)
            attributed.addAttributes([.font: ECFont.font(.regular, size: 20)], range: nsRange)
        }
        
        let label = UILabel()
        label.attributedText = attributed
        label.textColor = .label
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let showAllItem: ECDashedBorderView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: Constants.chevronRightImage)
        iv.tintColor = .white
        
        let label = UILabel()
        label.text = "Показать все программы бакалавриата"
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        
        let view = ECDashedBorderView()
        view.contentView.backgroundColor = UIColor.hex("#664DC8")
        view.showShadow = true
        view.cornerRadius = 40
        view.contentView.addSubview(iv)
        iv.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.programImageSize)
        }
        
        view.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(iv.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
        return view
    }()
    
    private var gridStack: UIStackView?
    
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
        guard let vm = vm as? MainScreenProgramsCellViewModel else { return }
        self.viewModel = vm
        showAllItem.setAction(action: vm.didTapShowAll)
        
        gridStack?.removeFromSuperview()
        
        let newGrid = makeGridStack(programs: vm.programs)
        contentView.addSubview(newGrid)
        newGrid.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        self.gridStack = newGrid
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
    }
    

    private func makeGridStack(programs: [ECProgramCategory]) -> UIStackView {
        let gridStack = UIStackView()
        gridStack.axis = .vertical
        gridStack.spacing = Constants.itemSpacing
        gridStack.distribution = .fillEqually
        
        let displayedPrograms = Array(programs.prefix(Constants.maxVisiblePrograms))
        var allItems: [UIView] = displayedPrograms.map { makeProgramItem(programCategory: $0) }
        allItems.append(showAllItem)
        
        
        let rows = allItems.chunked(into: 2)
        
        for row in rows {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = Constants.itemSpacing
            hStack.distribution = .fillEqually
            
            row.forEach { hStack.addArrangedSubview($0) }
            
            if row.count == 1 {
                hStack.addArrangedSubview(UIView())
            }
            
            hStack.snp.makeConstraints {
                $0.height.equalTo(hStack.snp.width).multipliedBy(0.5)
            }
            
            gridStack.addArrangedSubview(hStack)
        }
        
        return gridStack
    }

    private func makeProgramItem(programCategory: ECProgramCategory) -> ECDashedBorderView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        if let url = URL(string: programCategory.iconURL ?? "") {
            image.kf.setImage(with: url, placeholder: ImageConstants.SystemImages.questionMark.image)
        }
        
        let label = UILabel()
        label.text = programCategory.name.ru
        label.font = ECFont.font(.semiBold, size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
        
        let view = ECDashedBorderView()
        view.cornerRadius = 40
        view.contentView.backgroundColor = .white
        view.showShadow = true
        
        view.contentView.addSubview(image)
        image.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.programImageSize)
        }
        
        view.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
        
        view.setAction { [weak self] in
            self?.viewModel?.didTapProgram?(programCategory)
        }
        
        return view
    }
}
