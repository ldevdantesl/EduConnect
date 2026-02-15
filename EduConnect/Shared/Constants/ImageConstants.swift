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
    case universityScreenHeaderImage = "UniversityScreenHeaderImage"
    case programsScreenHeaderImage = "ProgramsScreenHeaderImage"
    case programsImage = "ProgramsImage"
    case professionsImage = "ProfessionsImage"
    case articlesImage = "ArticlesImage"
    case mainChooseProfessionImage = "MainChooseProfessionImage"
    case mainChooseENTImage = "MainChooseENTImage"
    case mainServicesTestImage = "MainServicesTestImage"
    case mainServicesProfessionImage = "MainServicesProfessionImage"
    case mainServicesUniversityImage = "MainServicesUniversityImage"
    case mainServicesCalendarImage = "MainServicesCalendarImage"
    case professionScreenImage = "ProfessionScreenImage"

    // Icons
    case tabBarIcon = "TabBarIcon"
    case accountIcon = "AccountIcon"
    case capIcon = "CapIcon"
    case checkmarkIcon = "CheckmarkIcon"
    case checkmarkIconBlue = "CheckmarkIconBlue"
    case geopositionIcon = "GeopositionIcon"
    case phoneIcon = "PhoneIcon"
    case emailIcon = "EmailIcon"
    case arrowRightIcon = "ArrowRightIcon"

    // Samples
    case universityImageSample = "UniversityImageSample"
    
    // SystemImage
    enum SystemImages: String {
        case questionMarkSystemImage = "questionmark.circle"
        case chevronRight = "chevron.right"
        case chevronLeft = "chevron.left"
        
        var image: UIImage? {
            UIImage(systemName: rawValue)
        }
    }

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}
