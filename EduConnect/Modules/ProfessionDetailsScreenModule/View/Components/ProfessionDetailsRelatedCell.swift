//
//  ProfessionDetailsRelatedCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 1.03.2026.
//

import UIKit
import SnapKit

struct ProfessionDetailsRelatedCellViewModel {
    let related: [ECProfession]
    let didTapRelated: ((ECProfession) -> Void)?
    
    init(related: [ECProfession], didTapRelated: ((ECProfession) -> Void)? = nil) {
        self.related = related
        self.didTapRelated = didTapRelated
    }
}

final class ProfessionDetailsRelatedCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants { }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionDetailsRelatedCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    
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
    public func configure(withVM vm: ProfessionDetailsRelatedCellViewModel) {
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() { }
    
    // MARK: - OBJC FUNC
}
