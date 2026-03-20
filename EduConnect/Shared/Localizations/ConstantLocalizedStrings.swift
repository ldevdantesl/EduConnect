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
        static let start = String(localized: .Localizables.commonStart)
        static let none = String(localized: .Localizables.commonNone)
        static let apply = String(localized: .Localizables.commonApply)
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
        static let show = String(localized: .Localizables.commonShow)
        static let hide = String(localized: .Localizables.commonHide)
        static let filter = String(localized: .Localizables.commonFilter)
        static let attention = String(localized: .Localizables.commonAttention)
        static let code = String(localized: .Localizables.commonCode)
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
    
    /// For __Profession__ purposes
    enum Profession {
        static let professionPlural = String(localized: .Localizables.professionProfessionPlural)
        static let profession = String(localized: .Localizables.professionProfession)
        static let headerSubtitle = String(localized: .Localizables.professionHeaderSubtitle)
        static let relatedProf = String(localized: .Localizables.professionRelatedProf)
        static let about = String(localized: .Localizables.professionAboutProfession)
        static let setEnt = String(localized: .Localizables.professionSetEnt)
        static let setEntSubtitle = String(localized: .Localizables.professionSetEntSubtitle)
        static let footerTitle = String(localized: .Localizables.professionFooterTitle)
        static let footerSubtitle = String(localized: .Localizables.professionFooterSubtitle)
        static let programs = Words.programPlural
        static let unis = Words.universityPlural
    }
    
    /// For __Program__ purposes
    enum Program {
        static let headerTitle = String(localized: .Localizables.programHeaderTitle)
        static let educationalPrograms = String(localized: .Localizables.programEducationalPrograms)
        static let fields = String(localized: .Localizables.programHeaderFields)
        static let aboutProgram = String(localized: .Localizables.programAboutProgram)
        static let relatedProfessions = String(localized: .Localizables.programRelatedProfessions)
        static let similarPrograms = String(localized: .Localizables.programSimilarPrograms)
        static let footerTitle = String(localized: .Localizables.programFooterTitle)
        static let footerSubtitle = String(localized: .Localizables.programFooterSubtitle)
        
        enum ByCategory {
            static let title = String(localized: .Localizables.programByCategoryTitle)
            static let footerSubtitle = String(localized: .Localizables.programByCategoryFooterSubtitle)
            static let error = String(localized: .Localizables.programByCategoryError)
        }
    }
    
    /// For __Universiry__flow
    enum University {
        static let university = String(localized: .Localizables.universityUniversity)
        static let filterUnis = String(localized: .Localizables.universityFilterUnis)
        
        enum Header {
            static let subtitle = String(localized: .Localizables.universityHeaderSubtitle)
            static let title = String(localized: .Localizables.universityHeaderTitle)
        }
        
        enum Filter {
            static let filter = String(localized: .Localizables.commonFilter)
            static let addedFilters = String(localized: .Localizables.universityAddedFilters)
        }
        
        enum Footer {
            static let title = String(localized: .Localizables.universityFooterTitle)
            static let subtitle = String(localized: .Localizables.universityFooterSubtitle)
        }
        
    }
    
    /// For __DEBUGGING__ purposes
    enum DEBUG {
        static let requestError = String(localized: .Localizables.debugRequestError)
        static let error = String(localized: .Localizables.debugError)
        static let tryLater = String(localized: .Localizables.debugTryLater)
        static let serverError = String(localized: .Localizables.debugServerError)
        static let logInAgain = String(localized: .Localizables.debugLogInAgain)
        static let sessionExpired = String(localized: .Localizables.debugSessionExpired)
        static let noResponseTryLater = String(localized: .Localizables.debugNoResponseTryLater)
        static let limitPassed = String(localized: .Localizables.debugLimitPassed)
        static let networkLost = String(localized: .Localizables.debugNetworkLost)
        static let noConnection = String(localized: .Localizables.debugNoConnection)
        static let useThisCode = String(localized: .Localizables.debugUseThisCode)
    }
    
    /// For __Main Screen__ page flow
    enum Main {
        static let showAllPrograms = String(localized: .Localizables.mainShowAllPrograms)
        static let showAllUniversities = String(localized: .Localizables.mainShowAllUniversities)
        static let showAllProfessions = String(localized: .Localizables.mainShowAllProfessions)
        
        enum Header {
            static let titleMain = String(localized: .Localizables.mainHeaderTitleMain)
            static let titleSecondary = String(localized: .Localizables.mainHeaderTitleSecondary)
            static let programs = String(localized: .Localizables.mainHeaderPrograms)
            static let unis = String(localized: .Localizables.mainHeaderUnis)
            static let budgetPlaces = String(localized: .Localizables.wordsBudgetPlaces)
        }
        
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
        
        enum JournalTab {
            static let titleMain = String(localized: .Localizables.mainJournalTitleMain)
            static let titleSecondary = String(localized: .Localizables.mainJournalTitleSecondary)
        }
        
        enum ProgramsTab {
            static let titleMain = String(localized: .Localizables.mainProgramsTitleMain)
            static let titleSecondary = String(localized: .Localizables.mainProgramTitleSecondary)
            static let showAll = String(localized: .Localizables.mainProgramsShowAll)
        }
        
        enum Steps {
            static let chooseProfession = String(localized: .Localizables.mainStepsChooseProfession)
            static let chooseEnt = String(localized: .Localizables.mainStepsChooseENT)
            static let chooseUni = String(localized: .Localizables.mainStepsChooseUni)
            static let showAllSteps = String(localized: .Localizables.mainStepsShowAllSteps)
            static let hideSteps = String(localized: .Localizables.mainStepsHideSteps)
            static let start = String(localized: .Localizables.commonStart)
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
            static let percentageSubtitle = String(localized: .Localizables.mainFooterPercentageSubtitle)
            static let description = String(localized: .Localizables.mainFooterDescription)
            static let programs = String(localized: .Localizables.wordsProgramPlural)
            static let privateUnis = String(localized: .Localizables.mainFooterPrivateUnis)
            static let budgetPlaces = String(localized: .Localizables.wordsBudgetPlaces)
        }
    }
    
    /// For General Purpose
    enum Words {
        static let title = String(localized: .Localizables.wordsTitle)
        static let type = String(localized: .Localizables.wordsType)
        static let category = String(localized: .Localizables.wordsCategory)
        static let price = String(localized: .Localizables.wordsPrice)
        static let privateKey = String(localized: .Localizables.wordsPrivateKey)
        static let governmentalKey = String(localized: .Localizables.wordsGovernmentalKey)
        static let from = String(localized: .Localizables.wordsFrom)
        static let to = String(localized: .Localizables.wordsTo)
        static let budgetPlaces = String(localized: .Localizables.wordsBudgetPlaces)
        static let budgetPlacesShort = String(localized: .Localizables.wordsBudgetPlacesShort)
        static let paidPlaces = String(localized: .Localizables.wordsPaidPlaces)
        static let paidPlacesShort = String(localized: .Localizables.wordsPaidPlacesShort)
        static let freePlaces = String(localized: .Localizables.wordsFreePlaces)
        static let fromAtoZ = String(localized: .Localizables.wordsFromAtoZ)
        static let fromZtoA = String(localized: .Localizables.wordsFromZtoA)
        
        static let tengePerYear = String(localized: .Localizables.wordsTengePerYear)
        static let notFound = String(localized: .Localizables.wordsNotFound)
        static let tryAgain = String(localized: .Localizables.wordsTryAgain)
        static let searchSomwhereElse = String(localized: .Localizables.wordsSearchSomwhereElse)
        static let programPlural = String(localized: .Localizables.wordsProgramPlural)
        static let universityPlural = String(localized: .Localizables.wordsUniversityPlural)
        static let calendar = String(localized: .Localizables.wordsCalendar)
        static let tryOtherSearch = String(localized: .Localizables.wordsTryOtherSearch)
        static let facultyPlural = String(localized: .Localizables.wordsFacultyPlural)
    }
    
    /// For __Application Status__
    enum Status {
        static let accepted = String(localized: .Localizables.statusAccepted)
        static let rejected = String(localized: .Localizables.statusRejected)
        static let inReview = String(localized: .Localizables.statusInReview)
        static let reviewed = String(localized: .Localizables.statusReviewed)
    }
}
