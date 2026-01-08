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
        static let signIn = String(localized: .Localizables.registrationSignIn)
        static let enterEmail = String(localized: .Localizables.registrationEnterEmail)
        static let enterEmailTextField = String(localized: .Localizables.registrationEnterEmailTextField)
        static let sendCodeButton = String(localized: .Localizables.registrationSendCodeButton)
        static let confirmSignIn = String(localized: .Localizables.registrationConfirmSignIn)
        static let checkEmail = String(localized: .Localizables.registrationCheckEmail)
        static let confirmCodeTextField = String(localized: .Localizables.registrationConfirmCodeTextField)
        static let resendCode = String(localized: .Localizables.registrationResendCode)
    }
    
    /// For __Common__ words
    enum Common {
        static let ok = String(localized: .Localizables.commonOk)
        static let cancel = String(localized: .Localizables.commonCancel)
        static let confirm = String(localized: .Localizables.commonConfirm)
    }
}
