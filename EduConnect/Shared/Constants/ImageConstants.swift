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
    case universityAdvantageCheckmarkIcon = "UniversityAdvantageCheckmarkIcon"
    case programsScreenHeaderImage = "ProgramsScreenHeaderImage"

    // Samples
    case universityImageSample = "UniversityImageSample"
    
    // SystemImage
    enum SystemImages: String {
        case questionMarkSystemImage = "questionmark.circle"
        
        var image: UIImage? {
            UIImage(systemName: rawValue)
        }
    }

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
