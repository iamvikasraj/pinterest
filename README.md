# Pinterest iOS App

A Pinterest-style iOS app built with SwiftUI using MVVM architecture.

## Why This Project

Most design work stops at mockups. This project is a deliberate counter-example: a Pinterest-style app built as a **native SwiftUI prototype that behaves like a real product** — real physics, real haptics, and real motion (via Rive) — so ideas can be validated before any production code is written.

It reflects a way of working where the line between prototype and production has blurred: not just prototyping in code, but shipping it. Native gestures, animated pin-to-detail transitions, a Rive-powered splash, and a centralized design system stand in for the philosophy behind it — faster ships, fewer surprises at handoff.

## Project Structure

```
pinterest/
│
├── Core/                          # App entry
│   └── pinterestApp.swift         # @main entry point
│
├── ContentView.swift              # Main container (tabs, navigation, sheets)
│
├── Views/                         # Screen-level views
│   ├── Main/                      # Main tab screens
│   │   ├── HomeView.swift
│   │   ├── SearchView.swift
│   │   ├── ChatView.swift
│   │   ├── ProfileView.swift
│   │   └── CreateView.swift
│   │
│   ├── Detail/                    # Detail screens
│   │   ├── PinDetailView.swift
│   │   ├── BoardDetailView.swift
│   │   ├── MessageDetailView.swift
│   │   ├── UserProfileDetailView.swift
│   │   └── SearchResultsView.swift
│   │
│   ├── Settings/                  # Settings screens
│   │   ├── SettingsView.swift
│   │   └── EditProfileView.swift
│   │
│   └── Launch/                    # Launch & splash
│       ├── LaunchScreenView.swift # Rive splash animation
│       └── RootView.swift
│
├── Components/                    # Reusable UI components
│   ├── Home/
│   │   ├── PinCard.swift
│   │   └── PinCardFramePreferenceKey.swift
│   ├── Chat/
│   │   └── ChatCards.swift
│   ├── Profile/
│   │   ├── NavigationTab.swift
│   │   └── ProfileSearchBar.swift
│   ├── Search/
│   │   ├── FeaturedBoardCard.swift
│   │   ├── HeroCarousel.swift
│   │   ├── SearchBar.swift
│   │   └── SearchSections.swift
│   └── Shared/
│       ├── BottomNavigation.swift
│       ├── CreateBottomSheet.swift
│       ├── OverlayComponents.swift
│       ├── PinDetailSheet.swift
│       └── UtilityComponents.swift
│
├── Models/                        # Data models
│   ├── Pin.swift
│   ├── Message.swift
│   ├── Update.swift
│   ├── CarouselItem.swift
│   ├── FeaturedBoard.swift
│   ├── SearchSection.swift
│   ├── Tab.swift
│   └── Route.swift
│
├── ViewModels/                    # MVVM view models
│   ├── ContentViewModel.swift
│   ├── HomeViewModel.swift
│   ├── SearchViewModel.swift
│   ├── ChatViewModel.swift
│   └── ProfileViewModel.swift
│
├── Services/                      # Data services
│   └── DataService.swift
│
├── Design/
│   └── DesignSystem.swift         # Typography, colors, spacing (4pt grid)
│
├── Resources/
│   ├── LaunchScreen.storyboard
│   ├── pinterest-splash.riv       # Rive splash animation asset
│   └── README_Rive.md             # Rive integration notes
│
└── Documentation/
    ├── ProjectOverview.md
    ├── FolderStructure.md
    ├── StyleGuide.md
    └── ...
```

## Key Features

- **MVVM Architecture** — Clean separation of concerns
- **Masonry Layout** — Pinterest-style grid with randomized aspect ratios
- **Rive Splash Animation** — Animated launch screen using Rive
- **Bottom Sheet Navigation** — Smooth sheet transitions
- **Design System** — Centralized typography & spacing (4pt grid)
- **Type-Safe Navigation** — Route enum for navigation
- **Animated Transitions** — Pin card to detail sheet, animated tab underlines
- **Profile Paging** — TabView paging with search/filter bars and tags
- **Create Overlay** — Slide-up create sheet as an overlay

## Quick Start

1. Open `pinterest.xcodeproj` in Xcode
2. Build and run on a simulator or device
3. **App Entry**: `Core/pinterestApp.swift`
4. **Main View**: `ContentView.swift`
5. **Design System**: `Design/DesignSystem.swift`

## Documentation

See `Documentation/ProjectOverview.md` for detailed information.

## About the Author

Built by **Vikas Raj Yadav**, a mobile-first design technologist with a computer science background and 10+ years in Indian fintech (Paytm, HDFC Bank, ET Money), currently Staff Product Designer at Loop Health — where he scaled Paytm Postpaid to 1M+ users in six months and led design systems and UX across heavily regulated fintech products.

Self-taught in product design since 2016, he's run through nearly every prototype-test loop there is (Sketch, Principle, Flinto, Framer X, Figma, After Effects, production code), and since 2021–22 has been building native iOS in real SwiftUI. Motion is second nature, but it's one lever inside a full product design practice — not the whole job.

He's also a Rive Ambassador and is building [designengineer.ing](https://designengineer.ing), a home for designers who code.
