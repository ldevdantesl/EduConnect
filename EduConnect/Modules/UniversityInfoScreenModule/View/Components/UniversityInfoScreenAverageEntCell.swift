//
//  UniversityInfoScreenAverageEntCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 31.01.2026.
//

import UIKit
import SnapKit

struct UniversityInfoScreenAverageEntCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = UniversityInfoScreenAverageEntCell.identifier
    var entScores: ECUniversity.EntScores
}

final class UniversityInfoScreenAverageEntCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants { }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityInfoScreenAverageEntCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let entTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Средний балл ЕНТ"
        label.font = ECFont.font(.bold, size: 22)
        label.numberOfLines = 1
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
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? UniversityInfoScreenAverageEntCellViewModel else { return }
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(entTitleLabel)
        entTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
