# EduConnect

EduConnect is an iOS application that helps users explore universities, academic programs, and professions in Kazakhstan.  
The app provides structured educational information and helps users navigate through institutions, study programs, and related career paths in one place.

The project focuses on clean architecture, modular design, and scalable UI development.

---

# Features

## Universities
- Browse universities
- View university details
- See available academic programs
- University logos and localized names

## Programs
- Browse programs by category
- Program details screen
- Related programs suggestions
- Program header with university information

## Professions
- Explore professions connected to academic programs
- Navigate from program → profession

## Localization
- Multi-language support
- Kazakh localization implemented
- Dynamic language switching inside the app

## Authentication
- Email based authentication
- Password creation and validation
- Registration confirmation via email code

## Sidebar Navigation
Main navigation includes:
- Main
- Universities
- Programs
- Professions
- Change language
- Logout

The sidebar also displays the current **application version**.

---

# Architecture

The project follows a **VIPER + MVVM hybrid architecture** for better scalability and modularity.

### VIPER modules include
- ProgramDetails
- ProgramsByCategory
- Authentication
- Sidebar navigation

### Layers
- **View** – UIKit UI components
- **Interactor** – business logic
- **Presenter** – presentation logic
- **Entity** – models
- **Router** – navigation and routing

This architecture helps keep modules isolated and maintainable.

---

# Technologies Used

- **Swift**
- **UIKit**
- **VIPER architecture**
- **MVVM patterns where appropriate**
- **Diffable Data Source**
- **Compositional Layout**
- **SnapKit** – AutoLayout DSL
- **Kingfisher** – image loading
- **SPM (Swift Package Manager)**

---

# Project Structure

```
EduConnect
│
├── App
│   ├── AppRouter
│   ├── DependencyContainer
│
├── Modules
│   ├── Authentication
│   ├── Programs
│   │   ├── ProgramDetails
│   │   ├── ProgramsByCategory
│   ├── Universities
│   ├── Professions
│
├── UI
│   ├── Cells
│   ├── Headers
│   ├── Components
│
├── Services
│   ├── API
│   ├── Networking
│
├── Resources
│   ├── Localizations
│   ├── Assets
```

---

# Networking

The application communicates with a backend API to retrieve:

- Universities
- Programs
- Program categories
- Professions
- Images and logos

All responses are decoded using **Swift Decodable models**.

---

# UI Approach

The UI is fully built with **UIKit programmatically**.

Key concepts used:
- UICollectionView Compositional Layout
- Diffable Data Sources
- Reusable collection view cells
- Modular UI components

This allows dynamic and flexible interfaces.

---

# Localization

Supported languages:

- English
- Kazakh

Localization uses structured constant strings and runtime language switching.

---

# Versioning

The app version is read dynamically from the bundle:

```
CFBundleShortVersionString
```

Displayed inside the sidebar menu.

---

# Installation

Clone the repository:

```
git clone https://github.com/your-repo/educonnect.git
```

Open the project:

```
open EduConnect.xcodeproj
```

Build and run using Xcode.

---

# Requirements

- Xcode 15+
- iOS 16+
- Swift 5.9+

---

# Future Improvements

- Favorites system
- Program filtering
- Search functionality
- Offline caching
- Notifications
- User profiles
- Expanded localization

---

# Author

**Buzurgmehr Rahimzoda**

iOS Developer focused on building scalable and modular applications.

---

# License

This project is proprietary software.

The source code is provided for viewing and educational purposes only.  
Copying, modifying, distributing, or using this code in commercial products is not permitted without explicit permission from the author.

Copyright © 2026 Buzurgmehr Rahimzoda
