//
//  ProfessionScreenProgsAndUnisCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 25.02.2026.
//

import UIKit
import SnapKit

struct ProfessionScreenProgsAndUnisCellViewModel: CellViewModelProtocol {
    let cellIdentifier: String = ProfessionScreenProgsAndUnisCell.identifier
}

final class ProfessionScreenProgsAndUnisCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants { }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionScreenProgsAndUnisCellViewModel?
    
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
        guard let vm = vm as? ProfessionScreenProgsAndUnisCellViewModel else { return }
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() { }
    
    // MARK: - OBJC FUNC
}
