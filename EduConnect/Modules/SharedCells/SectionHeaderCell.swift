//
//  SectionHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.01.2026.
//

import UIKit
import SnapKit

struct SectionHeaderCellViewModel: CellViewModelProtocol, Hashable {
    var cellIdentifier: String = "SectionHeaderCell"
    let title: String
    let titleFamily: ECFont.Family
    let titleSize: CGFloat
    let titleColor: UIColor
    let titleAlignment: NSTextAlignment
    
    init(
        title: String, titleFamily: ECFont.Family = .bold,
        titleSize: CGFloat, titleColor: UIColor = .label,
        titleAlignment: NSTextAlignment = .left
    ) {
        self.title = title
        self.titleFamily = titleFamily
        self.titleSize = titleSize
        self.titleColor = titleColor
        self.titleAlignment = titleAlignment
    }
}

final class SectionHeaderCell: UICollectionViewCell, ConfigurableCellProtocol {

    // MARK: - PROPERTIES
    private var viewModel: SectionHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        guard let vm = vm as? SectionHeaderCellViewModel else { return }
        titleLabel.text = vm.title
        titleLabel.font = ECFont.font(vm.titleFamily, size: vm.titleSize)
        titleLabel.textColor = vm.titleColor
        titleLabel.textAlignment = vm.titleAlignment
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
