# Pinterest iOS App

A Pinterest-style iOS app built with SwiftUI using MVVM architecture.

## 📱 Project Structure

```
pinterest/
│
├── 🚀 Core/                    # App entry & main container
│   ├── pinterestApp.swift      # @main entry point
│   └── ContentView.swift       # Main view (tabs, navigation, sheets)
│
├── 👁️ Views/                   # Screen-level views
│   ├── Main/                   # Main tab screens
│   │   ├── HomeView.swift
│   │   ├── SearchView.swift
│   │   ├── ChatView.swift
│   │   ├── ProfileView.swift
│   │   └── CreateView.swift
│   │
│   ├── Detail/                 # Detail screens
│   │   ├── PinDetailView.swift
│   │   ├── BoardDetailView.swift
│   │   ├── MessageDetailView.swift
│   │   ├── UserProfileDetailView.swift
│   │   └── SearchResultsView.swift
│   │
│   ├── Settings/               # Settings screens
│   │   ├── SettingsView.swift
│   │   └── EditProfileView.swift
│   │
│   └── Launch/                 # Launch screens
│       ├── LaunchScreenView.swift
│       └── RootView.swift
│
├── 🧩 Components/              # Reusable UI components
│   ├── Cards/                  # Card components
│   │   └── CardComponents.swift
│   ├── Navigation/             # Navigation components
│   │   └── NavigationComponents.swift
│   ├── Sheets/                 # Bottom sheets
│   │   ├── CreateBottomSheet.swift
│   │   └── PinDetailSheet.swift
│   ├── Search/                 # Search components
│   │   └── SearchComponents.swift
│   └── Utilities/              # Utility components
│       ├── CarouselComponents.swift
│       ├── SectionComponents.swift
│       ├── OverlayComponents.swift
│       ├── UtilityComponents.swift
│       └── PinCardFramePreferenceKey.swift
│
├── 📊 Data Layer/
│   ├── Models/                 # Data models
│   │   ├── Pin.swift
│   │   ├── Message.swift
│   │   ├── Update.swift
│   │   ├── CarouselItem.swift
│   │   ├── FeaturedBoard.swift
│   │   ├── SearchSection.swift
│   │   ├── Tab.swift
│   │   └── Route.swift
│   │
│   ├── ViewModels/             # MVVM view models
│   │   ├── ContentViewModel.swift
│   │   ├── HomeViewModel.swift
│   │   ├── SearchViewModel.swift
│   │   ├── ChatViewModel.swift
│   │   └── ProfileViewModel.swift
│   │
│   └── Services/               # Data services
│       └── DataService.swift
│
├── 🎨 Design/
│   └── DesignSystem.swift      # Typography, Colors, Spacing, etc.
│
├── 📚 Documentation/
│   ├── ProjectOverview.md
│   ├── FolderStructure.md
│   ├── StyleGuide.md
│   └── ...
│
└── 📦 Resources/
    └── LaunchScreen.storyboard
```

## 🎯 Key Features

- ✅ **MVVM Architecture** - Clean separation of concerns
- ✅ **Bottom Sheet Navigation** - Smooth sheet transitions
- ✅ **Design System** - Centralized typography & spacing (4pt grid)
- ✅ **Type-Safe Navigation** - Route enum for navigation
- ✅ **Animated Transitions** - Pin card to detail sheet animation

## 🚀 Quick Start

1. **App Entry**: `Core/pinterestApp.swift`
2. **Main View**: `Core/ContentView.swift`
3. **Bottom Nav**: `Components/Navigation/NavigationComponents.swift`
4. **Design System**: `Design/DesignSystem.swift`

## 📖 Documentation

See `Documentation/ProjectOverview.md` for detailed information.

