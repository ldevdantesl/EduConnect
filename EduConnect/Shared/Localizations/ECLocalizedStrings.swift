//
//  LocalizedStrings.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

public enum ECLocalizedStrings {
    
    /// For __Registration__ page flow
    enum Registration {
        
        enum Page1 {
            static let signInTitle = String(localized: .Localizables.registrationSignInTitle)
            static let enterEmailSubtitle = String(localized: .Localizables.registrationEnterEmailSubtitle)
            static let enterEmailTextField = String(localized: .Localizables.registrationEnterEmailTextField)
            static let sendCodeButton = String(localized: .Localizables.registrationSendCodeButton)
        }
        
        enum Page2 {
            static let confirmSignInTitle = String(localized: .Localizables.registrationConfirmSignInTitle)
            static let checkEmailSubtitle = String(localized: .Localizables.registrationCheckEmailSubtitle)
            static let confirmCodeTextField = String(localized: .Localizables.registrationConfirmCodeTextField)
            static let resendCodeUnderlineButton = String(localized: .Localizables.registrationResendCodeUnderlineButton)
        }
        
        enum Page3 {
            static let setPasswordTitle = String(localized: .Localizables.registrationSetPasswordTitle)
            static let setNewPasswordSubtitle = String(localized: .Localizables.registrationCreatePasswordSubtitle)
            static let newPasswordTextField = String(localized: .Localizables.registrationSetNewPasswordTextField)
            static let reenterPasswordTextField = String(localized: .Localizables.registrationReEnterPasswordTextField)
            static let savePasswordButton = String(localized: .Localizables.registrationSavePasswordButton)
        }
        
        enum Page4 {
            static let signInCompletedTitle = String(localized: .Localizables.registrationSignInCompletedTitle)
            static let signInCompletedSubtitle = String(localized: .Localizables.registrationSignInCompletedSubtitle)
            static let goToAccountButton = String(localized: .Localizables.registrationGoToAccountButton)
            static let goToMainButton = String(localized: .Localizables.registrationGoToMainButton)
        }
    }
    
    /// For __Common__ words
    enum Common {
        static let ok = String(localized: .Localizables.commonOk)
        static let cancel = String(localized: .Localizables.commonCancel)
        static let confirm = String(localized: .Localizables.commonConfirm)
    }
}
