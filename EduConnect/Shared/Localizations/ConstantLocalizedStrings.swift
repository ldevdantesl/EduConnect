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
            static let enterPhoneTextField = String(localized: .Localizables.registrationEnterPhone)
            static let enterPasswordTextField = String(localized: .Localizables.registrationEnterPasswordTextField)
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
            static let phone = String(localized: .Localizables.registrationPhone)
            static let email = String(localized: .Localizables.registrationEmail)
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
        static let attention = String(localized: .Localizables.commonAttention)
    }
    
    /// For __Account__ Tab
    enum Account {
        enum MainTab {
            static let tab = String(localized: .Localizables.accountMainTab)
            static let title = String(localized: .Localizables.accountMainTitle)
            static let lastApplications = String(localized: .Localizables.accountLastApplications)
            static let lastApplicationsSubtitle = String(localized: .Localizables.accountLastApplicationsSubtitle)
            static let welcomeMessage = String(localized: .Localizables.accountMainTabWelcomeMessage)
            static let adviceSection = String(localized: .Localizables.accountMainTabAdviceSection)
            static let adviceSubtitle = String(localized: .Localizables.accountMainTabAdviceSubtitle)
        }
        
        enum ApplicationTab {
            static let tab = String(localized: .Localizables.accountApplicationTab)
            static let title = String(localized: .Localizables.accountApplicationTitle)
            static let applicationsNotFound = String(localized: .Localizables.accountApplicationsNotFound)
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
        static let changeLanguage = String(localized: .Localizables.sidebarChangeLanguage)
        static let changeLanguageNotice = String(localized: .Localizables.sidebarChangeLanguageNotice)
        static let logOut = String(localized: .Localizables.sidebarLogout)
    }
    
    /// For __Articles__
    enum Article {
        static let article = String(localized: .Localizables.articlesArticle)
        static let articleNavigatorSubtitle = String(localized: .Localizables.articleArticleNavigatorSubtitle)
        static let moreToRead = String(localized: .Localizables.articleMoreToRead)
        static let noNewsInThisCategory = String(localized: .Localizables.articlesNoNewsInThisCategory)
        static let showAllArticles = String(localized: .Localizables.articlesShowAllArticles)
    }
    
    /// For __DEBUGGING__ purposes
    enum DEBUG {
        static let useThisCode = String(localized: .Localizables.debugUseThisCode)
    }
    
    /// For __Main Screen__ page flow
    enum Main {
        static let showAllPrograms = String(localized: .Localizables.mainShowAllPrograms)
        static let showAllUniversities = String(localized: .Localizables.mainShowAllUniversities)
        static let showAllProfessions = String(localized: .Localizables.mainShowAllProfessions)
        
        enum AcademicTab {
            static let titleMain = String(localized: .Localizables.mainAcademicTabTitleMain)
            static let titleCountry = String(localized: .Localizables.mainAcademicTabTitleCountry)
            static let universities = String(localized: .Localizables.mainAcademicTabUniversities)
            static let professions = String(localized: .Localizables.mainAcademicTabProfessions)
            static let programCategories = String(localized: .Localizables.mainAcademicTabProgramCategories)
        }
        
        enum CareersTab {
            static let titleMain = String(localized: .Localizables.mainCareersTabTitleMain)
            static let titleCountry = String(localized: .Localizables.mainAcademicTabTitleCountry)
        }
        
        enum ServicesTab {
            static let title = String(localized: .Localizables.mainServicesTabTitle)
            static let professionsOptions = String(localized: .Localizables.mainServicesTabProfessionOptions)
            static let universityHelp = String(localized: .Localizables.mainServicesTabUniversityHelp)
            static let calendar = String(localized: .Localizables.wordsCalendar)
        }
        
        enum Footer {
            static let title = String(localized: .Localizables.mainFooterTitle)
            static let percentageLabel = String(localized: .Localizables.mainFooterPercentageLabel)
        }
    }
    
    /// For General Purpose
    enum Words {
        static let budgetPlaces = String(localized: .Localizables.wordsBudgetPlaces)
        static let budgetPlacesShort = String(localized: .Localizables.wordsBudgetPlacesShort)
        static let paidPlaces = String(localized: .Localizables.wordsPaidPlaces)
        static let paidPlacesShort = String(localized: .Localizables.wordsPaidPlacesShort)
        
        static let notFound = String(localized: .Localizables.wordsNotFound)
        static let searchSomwhereElse = String(localized: .Localizables.wordsSearchSomwhereElse)
        static let programPlural = String(localized: .Localizables.wordsProgramPlural)
        static let universityPlural = String(localized: .Localizables.wordsUniversityPlural)
        static let calendar = String(localized: .Localizables.wordsCalendar)
    }
    
    /// For __Application Status__
    enum Status {
        static let accepted = String(localized: .Localizables.statusAccepted)
        static let rejected = String(localized: .Localizables.statusRejected)
        static let inReview = String(localized: .Localizables.statusInReview)
        static let reviewed = String(localized: .Localizables.statusReviewed)
    }
}
