# Pinterest App - Project Overview

## 🎯 Project Structure

This is a Pinterest-style iOS app built with SwiftUI using the MVVM architecture pattern.

## 📁 Folder Organization

### 🚀 Core App Files
```
Core/
├── pinterestApp.swift      # App entry point (@main)
└── ContentView.swift       # Main container view (tabs, navigation, sheets)
```

### 👁️ Views (Screen-Level Components)
```
Views/
├── Main/                   # Main tab screens
│   ├── HomeView.swift      # Home feed with pins grid
│   ├── SearchView.swift    # Search with carousel
│   ├── ChatView.swift      # Messages inbox
│   ├── ProfileView.swift   # User profile
│   └── CreateView.swift    # Create placeholder
│
├── Detail/                 # Detail screens (shown in sheets/navigation)
│   ├── PinDetailView.swift
│   ├── BoardDetailView.swift
│   ├── MessageDetailView.swift
│   ├── UserProfileDetailView.swift
│   └── SearchResultsView.swift
│
├── Settings/               # Settings screens
│   ├── SettingsView.swift
│   └── EditProfileView.swift
│
└── Launch/                # Launch/splash screens
    ├── LaunchScreenView.swift
    └── RootView.swift
```

### 🧩 Components (Reusable UI Pieces)
```
Components/
├── Cards/                  # Card components
│   └── CardComponents.swift  # PinCard, MessageCard, UpdateCard, FeaturedBoardCard
│
├── Navigation/            # Navigation components
│   └── NavigationComponents.swift  # BottomNavigationView, TabButton, NavigationTab
│
├── Sheets/                # Bottom sheet components
│   ├── CreateBottomSheet.swift
│   └── PinDetailSheet.swift
│
├── Search/                 # Search-related components
│   └── SearchComponents.swift  # SearchBar, ProfileSearchBar
│
└── Utilities/             # Utility components & helpers
    ├── CarouselComponents.swift    # HeroCarousel
    ├── SectionComponents.swift      # FeaturedBoardView, SearchSectionView
    ├── OverlayComponents.swift      # BottomOverlayView, OverlayOptionRow
    ├── UtilityComponents.swift      # UserProfileImage, RoundedCorner, etc.
    └── PinCardFramePreferenceKey.swift  # Frame tracking for animations
```

### 📊 Data Layer
```
Models/                     # Data models
├── Pin.swift
├── Message.swift
├── Update.swift
├── CarouselItem.swift
├── FeaturedBoard.swift
├── SearchSection.swift
├── Tab.swift               # Tab enum
└── Route.swift             # Navigation routes enum

ViewModels/                 # MVVM view models
├── ContentViewModel.swift  # Main app state (tabs, navigation, sheets)
├── HomeViewModel.swift
├── SearchViewModel.swift
├── ChatViewModel.swift
└── ProfileViewModel.swift

Services/                   # Data services
└── DataService.swift       # Protocol + MockDataService
```

### 🎨 Design System
```
Design/
└── DesignSystem.swift      # Typography, Colors, Spacing, CornerRadius, Shadows
```

### 📚 Documentation
```
Documentation/
├── ProjectOverview.md      # This file - Quick overview
├── FolderStructure.md      # Detailed folder structure
├── StyleGuide.md           # Design system reference
├── NavigationGuide.md      # How navigation works
└── ...
```

### 📦 Resources
```
Resources/
└── LaunchScreen.storyboard  # iOS launch screen
```

## 🔄 Data Flow

```
User Action
    ↓
View (UI)
    ↓
ViewModel (Business Logic)
    ↓
Service (Data)
    ↓
Model (Data Structure)
```

## 🎯 Key Features

1. **Tab Navigation**: 5 main tabs (Home, Search, Create, Chat, Profile)
2. **Bottom Sheets**: Create sheet and Pin detail sheet with animations
3. **In-Page Navigation**: NavigationStack for detail screens
4. **Design System**: Centralized typography, colors, spacing
5. **MVVM Architecture**: Clean separation of concerns

## 📝 Quick Reference

### Where to find things:

- **Bottom Navigation**: `Components/Navigation/NavigationComponents.swift`
- **Pin Cards**: `Components/Cards/CardComponents.swift`
- **Main App Logic**: `Core/ContentView.swift` + `ViewModels/ContentViewModel.swift`
- **Design Tokens**: `Design/DesignSystem.swift`
- **Tab Screens**: `Views/Main/`
- **Detail Screens**: `Views/Detail/`

### Adding New Features:

1. **New Screen**: Add to appropriate `Views/` subfolder
2. **New Component**: Add to appropriate `Components/` subfolder
3. **New Model**: Add to `Models/`
4. **New ViewModel**: Add to `ViewModels/`
5. **New Service**: Add to `Services/`

## 🚀 Getting Started

1. **App Entry**: `Core/pinterestApp.swift` → `RootView` → `ContentView`
2. **Main Flow**: `ContentView` manages tabs and navigation
3. **Tab Content**: `TabContentView` switches between main views
4. **Navigation**: `ContentViewModel` handles all navigation state

