# 📍 Project Map - Visual Guide

## 🗺️ Complete Project Structure

```
pinterest/
│
├── 🚀 Core/                          # App Foundation
│   ├── pinterestApp.swift            # Entry point (@main)
│   └── ContentView.swift             # Main container (tabs, nav, sheets)
│
├── 👁️ Views/                         # Screen-Level Views
│   │
│   ├── Main/                        # Main Tab Screens
│   │   ├── HomeView.swift           # Home feed (pin grid)
│   │   ├── SearchView.swift         # Search (carousel, sections)
│   │   ├── ChatView.swift           # Messages inbox
│   │   ├── ProfileView.swift         # User profile
│   │   └── CreateView.swift         # Create placeholder
│   │
│   ├── Detail/                       # Detail Screens
│   │   ├── PinDetailView.swift      # Pin detail (legacy)
│   │   ├── BoardDetailView.swift    # Board detail
│   │   ├── MessageDetailView.swift  # Message detail
│   │   ├── UserProfileDetailView.swift
│   │   └── SearchResultsView.swift
│   │
│   ├── Settings/                     # Settings Screens
│   │   ├── SettingsView.swift
│   │   └── EditProfileView.swift
│   │
│   └── Launch/                       # Launch Screens
│       ├── LaunchScreenView.swift   # Animated splash
│       └── RootView.swift           # Splash → Main transition
│
├── 🧩 Components/                    # Reusable UI Components
│   │
│   ├── Cards/                        # Card Components
│   │   └── CardComponents.swift     # PinCard, MessageCard, UpdateCard, FeaturedBoardCard
│   │
│   ├── Navigation/                   # Navigation Components
│   │   └── NavigationComponents.swift  # BottomNavigationView, TabButton, NavigationTab
│   │
│   ├── Sheets/                       # Bottom Sheet Components
│   │   ├── CreateBottomSheet.swift  # Create options sheet
│   │   └── PinDetailSheet.swift     # Pin detail sheet (with animation)
│   │
│   ├── Search/                       # Search Components
│   │   └── SearchComponents.swift   # SearchBar, ProfileSearchBar
│   │
│   └── Utilities/                    # Utility Components
│       ├── CarouselComponents.swift      # HeroCarousel
│       ├── SectionComponents.swift      # FeaturedBoardView, SearchSectionView
│       ├── OverlayComponents.swift      # BottomOverlayView, OverlayOptionRow
│       ├── UtilityComponents.swift      # UserProfileImage, RoundedCorner, etc.
│       └── PinCardFramePreferenceKey.swift  # Frame tracking
│
├── 📊 Data Layer/
│   │
│   ├── Models/                       # Data Models
│   │   ├── Pin.swift
│   │   ├── Message.swift
│   │   ├── Update.swift
│   │   ├── CarouselItem.swift
│   │   ├── FeaturedBoard.swift
│   │   ├── SearchSection.swift
│   │   ├── Tab.swift                # Tab enum
│   │   └── Route.swift              # Navigation routes enum
│   │
│   ├── ViewModels/                   # MVVM View Models
│   │   ├── ContentViewModel.swift   # Main app state (tabs, nav, sheets)
│   │   ├── HomeViewModel.swift      # Home state
│   │   ├── SearchViewModel.swift   # Search state
│   │   ├── ChatViewModel.swift     # Chat state
│   │   └── ProfileViewModel.swift  # Profile state
│   │
│   └── Services/                     # Data Services
│       └── DataService.swift        # Protocol + MockDataService
│
├── 🎨 Design/                        # Design System
│   └── DesignSystem.swift           # Typography, Colors, Spacing, CornerRadius, Shadows
│
├── 📚 Documentation/                 # Project Documentation
│   ├── ProjectMap.md               # This file
│   ├── ProjectOverview.md          # Detailed overview
│   ├── QuickReference.md            # Quick lookup
│   ├── FolderStructure.md           # Folder details
│   ├── StyleGuide.md                # Design system guide
│   ├── NavigationGuide.md           # Navigation guide
│   └── ...
│
└── 📦 Resources/                     # Resources
    └── LaunchScreen.storyboard      # iOS launch screen
```

## 🔄 Data Flow

```
User Interaction
    ↓
View (SwiftUI)
    ↓
ViewModel (Business Logic)
    ↓
Service (Data Layer)
    ↓
Model (Data Structure)
```

## 🎯 Feature Breakdown

### Home Feature
- **View**: `Views/Main/HomeView.swift`
- **ViewModel**: `ViewModels/HomeViewModel.swift`
- **Components**: `Components/Cards/CardComponents.swift` (PinCard)
- **Model**: `Models/Pin.swift`

### Search Feature
- **View**: `Views/Main/SearchView.swift`
- **ViewModel**: `ViewModels/SearchViewModel.swift`
- **Components**: 
  - `Components/Utilities/CarouselComponents.swift`
  - `Components/Utilities/SectionComponents.swift`
  - `Components/Search/SearchComponents.swift`
- **Models**: `Models/CarouselItem.swift`, `Models/FeaturedBoard.swift`, `Models/SearchSection.swift`

### Chat Feature
- **View**: `Views/Main/ChatView.swift`
- **ViewModel**: `ViewModels/ChatViewModel.swift`
- **Components**: `Components/Cards/CardComponents.swift` (MessageCard, UpdateCard)
- **Models**: `Models/Message.swift`, `Models/Update.swift`

### Profile Feature
- **View**: `Views/Main/ProfileView.swift`
- **ViewModel**: `ViewModels/ProfileViewModel.swift`
- **Components**: `Components/Search/SearchComponents.swift` (ProfileSearchBar)

### Bottom Sheets
- **Create Sheet**: `Components/Sheets/CreateBottomSheet.swift`
- **Pin Detail Sheet**: `Components/Sheets/PinDetailSheet.swift`
- **State Management**: `ViewModels/ContentViewModel.swift`

## 🚀 Entry Points

1. **App Start**: `Core/pinterestApp.swift`
2. **Root View**: `Views/Launch/RootView.swift`
3. **Main Container**: `Core/ContentView.swift`
4. **Tab Router**: `Core/ContentView.swift` → `TabContentView`

## 📝 Quick Lookup

| What You Need | Where to Find It |
|---------------|------------------|
| Bottom Navigation | `Components/Navigation/NavigationComponents.swift` |
| Pin Cards | `Components/Cards/CardComponents.swift` |
| Bottom Sheets | `Components/Sheets/` |
| Design Tokens | `Design/DesignSystem.swift` |
| Tab Logic | `ViewModels/ContentViewModel.swift` |
| Navigation Routes | `Models/Route.swift` |
| Main App View | `Core/ContentView.swift` |

