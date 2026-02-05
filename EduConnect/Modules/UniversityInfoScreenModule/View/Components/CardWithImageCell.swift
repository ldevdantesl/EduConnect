//
//  CardWithImageCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

struct CardWithImageCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = CardWithImageCell.identifier
    let image: UIImage
    let title: String
    let subtitle: String
}

final class CardWithImageCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants { }
    
    // MARK: - PROPERTIES
    
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
    public func configure() { }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() { }
    
    // MARK: - OBJC FUNC
}
