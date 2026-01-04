//
//  ECCollectionView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

final class ECCollectionView: UICollectionView {
    
    // MARK: - INIT
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init(layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNC
    public func register<Cell: ECCollectionViewCell>(cell: Cell.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
}
