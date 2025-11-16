# Quick Reference Guide

## 🗺️ Where to Find Things

### Navigation & Tabs
- **Bottom Navigation Bar**: `Components/Navigation/NavigationComponents.swift`
- **Tab Switching Logic**: `ViewModels/ContentViewModel.swift` → `selectTab()`
- **Tab Content Router**: `Core/ContentView.swift` → `TabContentView`

### Views by Feature

#### Home
- **View**: `Views/Main/HomeView.swift`
- **ViewModel**: `ViewModels/HomeViewModel.swift`
- **Components**: `Components/Cards/CardComponents.swift` (PinCard)

#### Search
- **View**: `Views/Main/SearchView.swift`
- **ViewModel**: `ViewModels/SearchViewModel.swift`
- **Components**: 
  - `Components/Utilities/CarouselComponents.swift` (HeroCarousel)
  - `Components/Utilities/SectionComponents.swift` (FeaturedBoardView, SearchSectionView)
  - `Components/Search/SearchComponents.swift` (SearchBar)

#### Chat
- **View**: `Views/Main/ChatView.swift`
- **ViewModel**: `ViewModels/ChatViewModel.swift`
- **Components**: `Components/Cards/CardComponents.swift` (MessageCard, UpdateCard)

#### Profile
- **View**: `Views/Main/ProfileView.swift`
- **ViewModel**: `ViewModels/ProfileViewModel.swift`
- **Components**: `Components/Search/SearchComponents.swift` (ProfileSearchBar)

### Bottom Sheets
- **Create Sheet**: `Components/Sheets/CreateBottomSheet.swift`
- **Pin Detail Sheet**: `Components/Sheets/PinDetailSheet.swift`
- **Sheet Management**: `ViewModels/ContentViewModel.swift` → `showCreateSheet()`, `showPinDetail()`

### Design System
- **All Design Tokens**: `Design/DesignSystem.swift`
  - Typography: `Typography.Display`, `Typography.Title`, `Typography.Body`, etc.
  - Colors: `AppColors.textPrimary`, `AppColors.pinterestRed`, etc.
  - Spacing: `Spacing.xs`, `Spacing.sm`, `Spacing.md`, etc.
  - Corner Radius: `CornerRadius.small`, `CornerRadius.medium`, etc.

### Navigation Flow
- **Routes**: `Models/Route.swift`
- **Navigation Logic**: `ViewModels/ContentViewModel.swift`
- **Destination Views**: `Core/ContentView.swift` → `destinationView()`

## 🔍 Common Tasks

### Add a New Tab Screen
1. Create view in `Views/Main/YourView.swift`
2. Add case to `Models/Tab.swift`
3. Add case in `Core/ContentView.swift` → `TabContentView`
4. Add button in `Components/Navigation/NavigationComponents.swift`

### Add a New Bottom Sheet
1. Create sheet in `Components/Sheets/YourSheet.swift`
2. Add state to `ViewModels/ContentViewModel.swift`
3. Add `.sheet()` modifier in `Core/ContentView.swift`

### Add a New Component
1. Determine category (Cards, Navigation, Sheets, Search, Utilities)
2. Add to appropriate `Components/[Category]/` folder
3. Group related components in same file

### Change Design Token
1. Update value in `Design/DesignSystem.swift`
2. All usages automatically update

## 📋 File Naming Conventions

- **Views**: `[Feature]View.swift` (e.g., `HomeView.swift`)
- **ViewModels**: `[Feature]ViewModel.swift` (e.g., `HomeViewModel.swift`)
- **Components**: `[Type]Components.swift` (e.g., `CardComponents.swift`)
- **Models**: `[Entity].swift` (e.g., `Pin.swift`)

## 🎨 Design System Usage

```swift
// Typography
Text("Title").font(Typography.Semantic.pageTitle)

// Colors
Text("Subtitle").foregroundColor(AppColors.textSecondary)

// Spacing
.padding(.horizontal, Spacing.lg)

// Corner Radius
.cornerRadius(CornerRadius.large)
```

