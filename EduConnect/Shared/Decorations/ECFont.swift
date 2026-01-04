//
//  ECFont.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

public enum ECFont {
    
    enum Family: String {
        case regular = "Montserrat-Regular"
        case medium = "Montserrat-Medium"
        case semiBold = "Montserrat-SemiBold"
        case bold = "Montserrat-Bold"
    }
    
    static func font(_ family: Family = .regular, size: CGFloat) -> UIFont {
        UIFont(name: family.rawValue, size: size)
        ?? UIFont.systemFont(ofSize: size)
    }
}
