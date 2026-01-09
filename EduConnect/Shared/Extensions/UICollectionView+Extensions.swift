//
//  UICollectionView+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell & ReusableCell>(cell: Cell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
}
