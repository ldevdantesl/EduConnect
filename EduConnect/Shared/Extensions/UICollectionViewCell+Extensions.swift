//
//  UICollectionViewCell+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.01.2026.
//

import UIKit

extension UICollectionViewCell: ReusableCellProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
