# EduConnect — University & Career Explorer for iOS

A native iOS app that helps students in Kazakhstan explore universities, academic programs, and career paths — all in one place. Built with **UIKit**, **VIPER architecture**, and fully programmatic UI.

## Screenshots

<p>
  <img width="180" alt="IMG_8845" src="https://github.com/user-attachments/assets/06d22aa3-4742-40ab-9865-53b11847093b" />
  <img width="180" alt="IMG_8846" src="https://github.com/user-attachments/assets/fcd6b551-5ac6-4722-b31d-741535045139" />
  <img width="180" alt="IMG_8847" src="https://github.com/user-attachments/assets/1136d806-0640-4620-8f5b-296ac8012d15" />
  <img width="180" alt="IMG_8848" src="https://github.com/user-attachments/assets/a1541e53-52db-4c5a-94bd-39dcdef02cd1" />
</p>
<p>
  <img width="180" alt="IMG_8849" src="https://github.com/user-attachments/assets/3382c1cf-5feb-494b-9a32-673e3b32056f" />
  <img width="180" alt="IMG_8850" src="https://github.com/user-attachments/assets/f8a88400-9ffc-46c4-911e-8b9bc4684102" />
  <img width="180" alt="IMG_8851" src="https://github.com/user-attachments/assets/2383ca01-c90d-4394-85c5-562ff8b48ea4" />
  <img width="180" alt="IMG_8852" src="https://github.com/user-attachments/assets/17dd48fd-433e-48ce-aff8-a7f01c72bd26" />
</p>
<p>
  <img width="180" alt="IMG_8853" src="https://github.com/user-attachments/assets/3808f6b4-0e3b-4e53-83b9-b67aaae66031" />
  <img width="180" alt="IMG_8854" src="https://github.com/user-attachments/assets/fdb584b5-3bd8-46ea-a337-1f9938f0de9d" />
  <img width="180" alt="IMG_8855" src="https://github.com/user-attachments/assets/8c530aa1-bd9d-45cb-a42f-a179083c8d71" />
  <img width="180" alt="IMG_8856" src="https://github.com/user-attachments/assets/87f75d2e-421d-47a7-987c-4ac4f59cb876" />
</p>

## Tech Stack

| Area | Details |
|------|---------|
| **Language** | Swift 5.9 |
| **UI** | UIKit, 100% programmatic — no Storyboards |
| **Backend** | Live REST API — authentication, universities, programs, professions |
| **Architecture** | VIPER + MVVM hybrid |
| **Layout** | UICollectionView Compositional Layout, Diffable Data Sources |
| **Networking** | Custom API layer with Decodable models |
| **Dependencies** | SnapKit (Auto Layout), Kingfisher (image loading) via SPM |
| **Localization** | English + Russian + Kazakh |
| **Auth** | Email-based registration with code confirmation |
| **Minimum Target** | iOS 15.0+ |

## Architecture

```
┌─────────────────────────────────────────────────┐
│                    VIPER Module                  │
│                                                  │
│  View ◀──▶ Presenter ◀──▶ Interactor            │
│                │                  │              │
│                ▼                  ▼              │
│             Router            Entities           │
└─────────────────────────────────────────────────┘

Modules: Authentication, ProgramDetails, ProgramsByCategory,
         Universities, Professions, Sidebar Navigation
```

Each feature is a self-contained VIPER module with its own View, Interactor, Presenter, Entity, and Router. Dependencies are injected through a central DI container, keeping modules isolated and independently testable.

**Backend integration** 
— the app communicates with a live REST API for all data — universities, programs, professions, categories, and authentication. All networking is built on a custom API layer with structured request/response handling and Decodable model parsing. No mock data or hardcoded JSON.

## Highlights

**Full VIPER implementation** — not just MVC renamed. Each module has strict layer separation with protocols defining every boundary. The Router handles all navigation, the Interactor owns business logic, and the Presenter transforms data for the View.

**Compositional Layout + Diffable Data Sources** — complex, multi-section collection views with self-sizing cells, category-based browsing, and smooth data updates without manual `reloadData` calls.

**Dependency injection** — a custom DI container wires up all modules at launch, making it straightforward to swap implementations for testing or feature flags.

**Programmatic UI throughout** — every view, constraint, and layout is built in code using SnapKit. No Interface Builder files in the project.

## Project Structure

```
EduConnect/
├── App/
│   ├── AppRouter              # Root navigation coordinator
│   └── DependencyContainer    # DI setup
├── Modules/
│   ├── Authentication/        # Login, registration, email verification
│   ├── Programs/
│   │   ├── ProgramDetails/    # Program info + related suggestions
│   │   └── ProgramsByCategory/# Category-based browsing
│   ├── Universities/          # University list + details
│   └── Professions/           # Career paths linked to programs
├── UI/
│   ├── Cells/                 # Reusable collection view cells
│   ├── Headers/               # Section headers
│   └── Components/            # Shared UI elements
├── Services/
│   ├── API/                   # Endpoint definitions
│   └── Networking/            # Request/response handling
└── Resources/
    ├── Localizations/         # en, kk string files
    └── Assets/                # Images, colors
```

## Getting Started

```bash
git clone https://github.com/ldevdantesl/EduConnect.git
cd EduConnect
open EduConnect.xcodeproj
# Cmd + R to build and run
```

Requires Xcode 15+ and iOS 16+.

## License

Copyright © 2026 Buzurgmehr Rahimzoda. All rights reserved.

This source code is provided for viewing and educational purposes only. Copying, modifying, distributing, or using this code in commercial products is not permitted without explicit written permission from the author.

## Contact

Buzurgmehr Rahimzoda — [ldevdantesl@gmail.com](mailto:ldevdantesl@gmail.com) · [GitHub](https://github.com/ldevdantesl)
