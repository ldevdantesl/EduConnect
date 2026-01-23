//
//  ImageConstants.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

public enum ImageConstants: String {

    // Images
    case appLogo = "AppLogo"

    // Icons
    case tabBarIconImage = "TabBarIconImage"
    case accountIconImage = "AccountIconImage"
    case universityCapIconImage = "UniversityCapIconImage"
    case universityScreenHeaderImage = "UniversityScreenHeaderImage"

    // Samples
    case universityImageSample = "UniversityImageSample"

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
