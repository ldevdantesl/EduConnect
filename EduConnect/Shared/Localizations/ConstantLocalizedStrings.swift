//
//  LocalizedStrings.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit

public enum ConstantLocalizedStrings {
    
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
        
        enum Words {
            static let login = String(localized: .Localizables.registrationLogin)
            static let register = String(localized: .Localizables.registrationRegister)
        }
    }
    
    /// For __Common__ words
    enum Common {
        static let add = String(localized: .Localizables.commonAdd)
        static let ok = String(localized: .Localizables.commonOk)
        static let cancel = String(localized: .Localizables.commonCancel)
        static let confirm = String(localized: .Localizables.commonConfirm)
        static let edit = String(localized: .Localizables.commonEdit)
        static let save = String(localized: .Localizables.commonSave)
        static let set = String(localized: .Localizables.commonSet)
        static let choose = String(localized: .Localizables.commonChoose)
        static let subject = String(localized: .Localizables.commonSubject)
        static let max = String(localized: .Localizables.commonMax)
        static let description = String(localized: .Localizables.commonDescription)
        static let files = String(localized: .Localizables.commonFiles)
        static let noFileSelected = String(localized: .Localizables.commonNoFileSelected)
        static let browse = String(localized: .Localizables.commonBrowse)
        static let type = String(localized: .Localizables.commonType)
        static let city = String(localized: .Localizables.commonCity)
        static let state = String(localized: .Localizables.commonState)
        static let international = String(localized: .Localizables.commonInternational)
        static let phoneNumber = String(localized: .Localizables.commonPhoneNumber)
        static let loading = String(localized: .Localizables.commonLoading)
        static let search = String(localized: .Localizables.commonSearch)
        static let sort = String(localized: .Localizables.commonSort)
    }
    
    /// For __Account__ Tab
    enum Account {
        enum MainTab {
            static let tab = String(localized: .Localizables.accountMainTab)
            static let title = String(localized: .Localizables.accountMainTitle)
        }
        
        enum ApplicationTab {
            static let tab = String(localized: .Localizables.accountApplicationTab)
            static let title = String(localized: .Localizables.accountApplicationTitle)
        }
        
        enum MyUniversityTab {
            static let tab = String(localized: .Localizables.accountMyUnisTab)
            static let title = String(localized: .Localizables.accountMyUnisTitle)
        }
        
        enum Expandable {
            enum PersonalInfo {
                static let title = String(localized: .Localizables.accountPersonalInfoTitle)
                static let name = String(localized: .Localizables.accountPersonalInfoName)
                static let surname = String(localized: .Localizables.accountPersonalInfoSurname)
                static let patronymic = String(localized: .Localizables.accountPersonalInfoPatronymic)
            }
            
            enum FamilyInfo {
                static let title = String(localized: .Localizables.accountFamilyInfoTitle)
                static let father = String(localized: .Localizables.accountFamilyInfoFather)
                static let mother = String(localized: .Localizables.accountFamilyInfoMother)
                static let addContact = String(localized: .Localizables.accountFamilyAddContact)
                static let popupTitle = addContact
                static let contact = String(localized: .Localizables.accountFamilyContact)
            }
            
            enum Education {
                static let title = String(localized: .Localizables.accountEducationTitle)
                static let school = String(localized: .Localizables.accountEducationSchool)
                static let finalClass = String(localized: .Localizables.accountEducationFinalClass)
                static let averageScore = String(localized: .Localizables.accountEducationAverageScore)
            }
            
            enum ENT {
                static let title = String(localized: .Localizables.accountEntTitle)
                static let popupTitle = String(localized: .Localizables.accountEntPopupTitle)
                static let yearOfSubmission = String(localized: .Localizables.accountYearOfSubmisison)
                static let entSubjects = String(localized: .Localizables.accountEntSubjects)
                static let addEntSubjects = String(localized: .Localizables.accountEntPopupTitle)
                static let chooseSubject = "\(String(localized: .Localizables.commonChoose)) \(String(localized: .Localizables.commonSubject))"
                static let score = String(localized: .Localizables.accountEntScore)
            }
            
            enum ExtraActivity {
                static let title = String(localized: .Localizables.accountExtraActivityTitle)
                static let popupTitle = String(localized: .Localizables.accountExtraActivityPopupTitle)
                static let addActivity = String(localized: .Localizables.accountExtraActivityPopupTitle)
                static let typeOfActivity = String(localized: .Localizables.accountExtraActivityTypeOfActivity)
                static let chooseActivity = String(localized: .Localizables.accountExtraActivityChooseActivity)
                static let describeActivity = String(localized: .Localizables.accountExtraActivityDescribeActivity)
            }
            
            enum Olympiad {
                static let title = String(localized: .Localizables.accountOlympiadTitle)
                static let popupTitle = String(localized: .Localizables.accountOlympiadPopupTitle)
                static let olympiad = String(localized: .Localizables.accountOlympiad)
                static let add = String(localized: .Localizables.accountOlympiadPopupTitle)
                static let yearOfSubmission = String(localized: .Localizables.accountYearOfSubmisison)
                static let chooseOlympiad = String(localized: .Localizables.accountOlympiadChooseOlympiad)
            }
        }
        
        enum Words {
            static let name = String(localized: .Localizables.accountName)
            static let surname = String(localized: .Localizables.accountSurname)
            static let patronymic = String(localized: .Localizables.accountPatronymic)
        }
    }
    
    /// For __Sidebar__ Container
    enum Sidebar {
        static let main = String(localized: .Localizables.sidebarMain)
        static let universities = String(localized: .Localizables.sidebarUniversities)
        static let programs = String(localized: .Localizables.sidebarPrograms)
        static let professions = String(localized: .Localizables.sidebarProfessions)
        static let tests = String(localized: .Localizables.sidebarTests)
        static let articles = String(localized: .Localizables.sidebarArticles)
        static let calendar = String(localized: .Localizables.sidebarCalendar)
        static let logOut = String(localized: .Localizables.sidebarLogout)
    }
}
