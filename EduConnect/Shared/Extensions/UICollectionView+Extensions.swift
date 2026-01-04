//
//  UICollectionView+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

extension UICollectionView {
    public func register<Cell: ECCollectionViewCell>(cell: Cell.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
}
