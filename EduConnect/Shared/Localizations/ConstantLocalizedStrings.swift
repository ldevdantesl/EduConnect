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
        static let remove = String(localized: .Localizables.commonRemove)
        static let current = String(localized: .Localizables.commonCurrent)
        static let year = String(localized: .Localizables.commonYear)
        static let contract = String(localized: .Localizables.commonContract)
        static let budget = String(localized: .Localizables.commonBudget)
        static let contacts = String(localized: .Localizables.commonContacts)
    }
    
    /// For __Account__ Tab
    enum Account {
        enum MainTab {
            static let tab = String(localized: .Localizables.accountMainTab).acceptingNewLines
            static let title = String(localized: .Localizables.accountMainTitle).acceptingNewLines
            static let lastApplications = String(localized: .Localizables.accountLastApplications).acceptingNewLines
            static let lastApplicationsSubtitle = String(localized: .Localizables.accountLastApplicationsSubtitle).acceptingNewLines
            static let welcomeMessage = String(localized: .Localizables.accountMainTabWelcomeMessage).acceptingNewLines
            static let adviceSection = String(localized: .Localizables.accountMainTabAdviceSection).acceptingNewLines
            static let adviceSubtitle = String(localized: .Localizables.accountMainTabAdviceSubtitle).acceptingNewLines
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
        static let article = String(localized: .Localizables.articlesArticle).acceptingNewLines
        static let articleNavigatorSubtitle = String(localized: .Localizables.articleArticleNavigatorSubtitle).acceptingNewLines
        static let moreToRead = String(localized: .Localizables.articleMoreToRead).acceptingNewLines
        static let noNewsInThisCategory = String(localized: .Localizables.articlesNoNewsInThisCategory).acceptingNewLines
        static let showAllArticles = String(localized: .Localizables.articlesShowAllArticles).acceptingNewLines
    }
    
    /// For __Profession__ purposes
    enum Profession {
        static let professionPlural = String(localized: .Localizables.professionProfessionPlural).acceptingNewLines
        static let profession = String(localized: .Localizables.professionProfession).acceptingNewLines
        static let headerSubtitle = String(localized: .Localizables.professionHeaderSubtitle).acceptingNewLines
        static let relatedProf = String(localized: .Localizables.professionRelatedProf).acceptingNewLines
        static let about = String(localized: .Localizables.professionAboutProfession).acceptingNewLines
        static let setEnt = String(localized: .Localizables.professionSetEnt).acceptingNewLines
        static let setEntSubtitle = String(localized: .Localizables.professionSetEntSubtitle).acceptingNewLines
        static let footerTitle = String(localized: .Localizables.professionFooterTitle).acceptingNewLines
        static let footerSubtitle = String(localized: .Localizables.professionFooterSubtitle).acceptingNewLines
        static let programs = Words.programPlural.acceptingNewLines
        static let unis = Words.universityPlural.acceptingNewLines
    }
    
    /// For __Program__ purposes
    enum Program {
        static let headerTitle = String(localized: .Localizables.programHeaderTitle).acceptingNewLines
        static let educationalPrograms = String(localized: .Localizables.programEducationalPrograms).acceptingNewLines
        static let fields = String(localized: .Localizables.programHeaderFields).acceptingNewLines
        static let aboutProgram = String(localized: .Localizables.programAboutProgram).acceptingNewLines
        static let relatedProfessions = String(localized: .Localizables.programRelatedProfessions).acceptingNewLines
        static let similarPrograms = String(localized: .Localizables.programSimilarPrograms).acceptingNewLines
        static let footerTitle = String(localized: .Localizables.programFooterTitle).acceptingNewLines
        static let footerSubtitle = String(localized: .Localizables.programFooterSubtitle).acceptingNewLines
        
        enum ByCategory {
            static let title = String(localized: .Localizables.programByCategoryTitle).acceptingNewLines
            static let footerSubtitle = String(localized: .Localizables.programByCategoryFooterSubtitle).acceptingNewLines
            static let error = String(localized: .Localizables.programByCategoryError).acceptingNewLines
        }
    }
    
    /// For __Universiry__flow
    enum University {
        static let university = String(localized: .Localizables.universityUniversity).acceptingNewLines
        static let filterUnis = String(localized: .Localizables.universityFilterUnis).acceptingNewLines
        static let andMore = String(localized: .Localizables.universityAndMore).acceptingNewLines
        static let fields = Program.fields.acceptingNewLines
        static let paidPlaces = String(localized: .Localizables.universityPaidPlaces).acceptingNewLines
        static let budgetPlaces = String(localized: .Localizables.universityBudgetPlaces).acceptingNewLines
        static let scoreBudget = String(localized: .Localizables.universityScoreBudget).acceptingNewLines
        static let scorePaid = String(localized: .Localizables.universityScorePaid).acceptingNewLines
        static let priceNotSet = String(localized: .Localizables.universityPriceNotSet).acceptingNewLines

        static let profession = Profession.professionPlural.acceptingNewLines
        static let dormitory = String(localized: .Localizables.universityFilterWordsDormitory).acceptingNewLines
        static let militaryDepartmentShort = String(localized: .Localizables.universityMilitaryDepartmentShort).acceptingNewLines
        static let militaryDepartmentCenterShort = String(localized: .Localizables.universityMilitaryDepartmentCenterShort).acceptingNewLines
        static let uniFor = String(localized: .Localizables.universityUniFor).acceptingNewLines
        static let admission = String(localized: .Localizables.universityAdmission).acceptingNewLines
        static let application = String(localized: .Localizables.universityApplication).acceptingNewLines
        static let averageScoreENT = String(localized: .Localizables.universityAverageScoreENT).acceptingNewLines
        static let aboutUni = String(localized: .Localizables.universityAboutUni).acceptingNewLines
        static let programsPlural = Sidebar.programs.acceptingNewLines
        static let professionPlural = Profession.professionPlural.acceptingNewLines
        static let contact = Common.contacts
        
        enum Header {
            static let subtitle = String(localized: .Localizables.universityHeaderSubtitle).acceptingNewLines
            static let title = String(localized: .Localizables.universityHeaderTitle).acceptingNewLines
        }
        
        enum Filter {
            static let filter = String(localized: .Localizables.commonFilter).acceptingNewLines
            static let addedFilters = String(localized: .Localizables.universityAddedFilters).acceptingNewLines
            static let with = String(localized: .Localizables.universityFilterWith).acceptingNewLines
            static let without = String(localized: .Localizables.universityFilterWithout).acceptingNewLines
            
            enum Words{
                static let city = String(localized: .Localizables.universityFilterWordsCity).acceptingNewLines
                static let profession = String(localized: .Localizables.universityFilterWordsProfession).acceptingNewLines
                static let typeOfUni = String(localized: .Localizables.universityFilterWordsTypeOfUni).acceptingNewLines
                static let militaryDepartment = String(localized: .Localizables.universityFilterWordsMilitaryDepartment).acceptingNewLines
                static let dormitory = University.dormitory.acceptingNewLines
                static let price = String(localized: .Localizables.universityFilterWordsPrice).acceptingNewLines
                static let sort = Common.sort.acceptingNewLines
            }
        }
        
        enum Sort {
            static let byDefault = String(localized: .Localizables.universitySortByDefault).acceptingNewLines
            static let byNameFromAToZ = String(localized: .Localizables.universitySortByNameFromAToZ).acceptingNewLines
            static let byNameFromZToA = String(localized: .Localizables.universitySortByNameFromZToA).acceptingNewLines
            static let byPriceUp = String(localized: .Localizables.universitySortByPriceUp).acceptingNewLines
            static let byPriceDown = String(localized: .Localizables.universitySortByPriceDown).acceptingNewLines
        }
        
        enum Footer {
            static let title = String(localized: .Localizables.universityFooterTitle).acceptingNewLines
            static let subtitle = String(localized: .Localizables.universityFooterSubtitle).acceptingNewLines
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
        static let showAllPrograms = String(localized: .Localizables.mainShowAllPrograms).acceptingNewLines
        static let showAllUniversities = String(localized: .Localizables.mainShowAllUniversities).acceptingNewLines
        static let showAllProfessions = String(localized: .Localizables.mainShowAllProfessions).acceptingNewLines
        
        enum Header {
            static let titleMain = String(localized: .Localizables.mainHeaderTitleMain).acceptingNewLines
            static let titleSecondary = String(localized: .Localizables.mainHeaderTitleSecondary).acceptingNewLines
            static let programs = String(localized: .Localizables.mainHeaderPrograms).acceptingNewLines
            static let unis = String(localized: .Localizables.mainHeaderUnis).acceptingNewLines
            static let budgetPlaces = String(localized: .Localizables.wordsBudgetPlaces).acceptingNewLines
        }
        
        enum AcademicTab {
            static let titleMain = String(localized: .Localizables.mainAcademicTabTitleMain).acceptingNewLines
            static let titleCountry = String(localized: .Localizables.mainAcademicTabTitleCountry).acceptingNewLines
            static let universities = String(localized: .Localizables.mainAcademicTabUniversities).acceptingNewLines
            static let professions = String(localized: .Localizables.mainAcademicTabProfessions).acceptingNewLines
            static let programCategories = String(localized: .Localizables.mainAcademicTabProgramCategories).acceptingNewLines
        }
        
        enum CareersTab {
            static let titleMain = String(localized: .Localizables.mainCareersTabTitleMain).acceptingNewLines
            static let titleCountry = String(localized: .Localizables.mainAcademicTabTitleCountry).acceptingNewLines
        }
        
        enum JournalTab {
            static let titleMain = String(localized: .Localizables.mainJournalTitleMain).acceptingNewLines
            static let titleSecondary = String(localized: .Localizables.mainJournalTitleSecondary).acceptingNewLines
        }
        
        enum ProgramsTab {
            static let titleMain = String(localized: .Localizables.mainProgramsTitleMain).acceptingNewLines
            static let titleSecondary = String(localized: .Localizables.mainProgramTitleSecondary).acceptingNewLines
            static let showAll = String(localized: .Localizables.mainProgramsShowAll).acceptingNewLines
        }
        
        enum Steps {
            static let chooseProfession = String(localized: .Localizables.mainStepsChooseProfession).acceptingNewLines
            static let chooseEnt = String(localized: .Localizables.mainStepsChooseENT).acceptingNewLines
            static let chooseUni = String(localized: .Localizables.mainStepsChooseUni).acceptingNewLines
            static let showAllSteps = String(localized: .Localizables.mainStepsShowAllSteps).acceptingNewLines
            static let hideSteps = String(localized: .Localizables.mainStepsHideSteps).acceptingNewLines
            static let start = String(localized: .Localizables.commonStart).acceptingNewLines
        }
        
        enum ServicesTab {
            static let title = String(localized: .Localizables.mainServicesTabTitle).acceptingNewLines
            static let professionsOptions = String(localized: .Localizables.mainServicesTabProfessionOptions).acceptingNewLines
            static let universityHelp = String(localized: .Localizables.mainServicesTabUniversityHelp).acceptingNewLines
            static let calendar = String(localized: .Localizables.wordsCalendar).acceptingNewLines
        }
        
        enum Footer {
            static let title = String(localized: .Localizables.mainFooterTitle).acceptingNewLines
            static let percentageLabel = String(localized: .Localizables.mainFooterPercentageLabel).acceptingNewLines
            static let percentageSubtitle = String(localized: .Localizables.mainFooterPercentageSubtitle).acceptingNewLines
            static let description = String(localized: .Localizables.mainFooterDescription).acceptingNewLines
            static let programs = String(localized: .Localizables.wordsProgramPlural).acceptingNewLines
            static let privateUnis = String(localized: .Localizables.mainFooterPrivateUnis).acceptingNewLines
            static let budgetPlaces = String(localized: .Localizables.wordsBudgetPlaces).acceptingNewLines
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
        static let education = String(localized: .Localizables.wordsEducation)
        
        static let tengePerYear = String(localized: .Localizables.wordsTengePerYear)
        static let notFound = String(localized: .Localizables.wordsNotFound)
        static let tryAgain = String(localized: .Localizables.wordsTryAgain)
        static let searchSomwhereElse = String(localized: .Localizables.wordsSearchSomwhereElse)
        static let programPlural = String(localized: .Localizables.wordsProgramPlural)
        static let universityPlural = String(localized: .Localizables.wordsUniversityPlural)
        static let calendar = String(localized: .Localizables.wordsCalendar)
        static let tryOtherSearch = String(localized: .Localizables.wordsTryOtherSearch)
        static let facultyPlural = String(localized: .Localizables.wordsFacultyPlural)
        static let cityPlural = String(localized: .Localizables.wordsCityPlural)
    }
    
    /// For __Application Status__
    enum Status {
        static let accepted = String(localized: .Localizables.statusAccepted)
        static let rejected = String(localized: .Localizables.statusRejected)
        static let inReview = String(localized: .Localizables.statusInReview)
        static let reviewed = String(localized: .Localizables.statusReviewed)
    }
}
