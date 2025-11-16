# Project Folder Structure

This document outlines the organized folder structure of the Pinterest app.

## 📁 Root Structure

```
pinterest/
├── Core/                    # App entry point and main content
├── Views/                  # All SwiftUI views organized by category
├── Components/             # Reusable UI components
├── Models/                  # Data models
├── ViewModels/              # MVVM view models
├── Services/                # Data services and business logic
├── Design/                  # Design system and style guide
├── Documentation/          # Project documentation
├── Resources/               # Storyboards and other resources
└── Assets.xcassets/         # Images and assets
```

## 📂 Detailed Structure

### Core/
Contains the app's entry point and main content view.

- `pinterestApp.swift` - App entry point (`@main`)
- `ContentView.swift` - Main content view with navigation and tab management

### Views/
All SwiftUI views organized by their purpose.

#### Views/Main/
Main tab views that appear in the bottom navigation.

- `HomeView.swift` - Home feed with pins grid
- `SearchView.swift` - Search interface with carousel and sections
- `ChatView.swift` - Messages and updates inbox
- `ProfileView.swift` - User profile with tabs
- `CreateView.swift` - Create new pin/board view

#### Views/Detail/
Detail screens navigated to from main views.

- `PinDetailView.swift` - Individual pin detail view
- `BoardDetailView.swift` - Board detail view
- `MessageDetailView.swift` - Individual message conversation
- `UserProfileDetailView.swift` - Other user's profile
- `SearchResultsView.swift` - Search results view

#### Views/Settings/
Settings and profile management screens.

- `SettingsView.swift` - App settings
- `EditProfileView.swift` - Edit user profile

#### Views/Launch/
Launch and splash screens.

- `LaunchScreenView.swift` - Animated splash screen
- `RootView.swift` - Root view managing splash-to-main transition

### Components/
Reusable UI components organized by **feature**.

#### Components/Home/
- `PinCard.swift` - Pin card component for home grid
- `PinCardFramePreferenceKey.swift` - Frame tracking for animations

#### Components/Search/
- `HeroCarousel.swift` - Main carousel component
- `SearchBar.swift` - Search input bar
- `SearchSections.swift` - FeaturedBoardView, SearchSectionView
- `FeaturedBoardCard.swift` - Featured board card component

#### Components/Chat/
- `ChatCards.swift` - MessageCard, UpdateCard

#### Components/Profile/
- `ProfileSearchBar.swift` - Profile search bar with expandable content
- `NavigationTab.swift` - Tab navigation component

#### Components/Shared/
- `BottomNavigation.swift` - BottomNavigationView, TabButton (used across all tabs)
- `CreateBottomSheet.swift` - Create options bottom sheet
- `PinDetailSheet.swift` - Pin detail bottom sheet with animation
- `OverlayComponents.swift` - BottomOverlayView, OverlayOptionRow
- `UtilityComponents.swift` - UserProfileImage, RoundedCorner, ScrollOffsetPreferenceKey, View extensions

### Models/
Data models representing app entities.

- `Pin.swift` - Pin data model
- `Message.swift` - Message data model
- `Update.swift` - Update data model
- `CarouselItem.swift` - Carousel item model
- `FeaturedBoard.swift` - Featured board model
- `SearchSection.swift` - Search section model
- `Tab.swift` - Tab enumeration
- `Route.swift` - Navigation route enumeration

### ViewModels/
MVVM view models managing view state and business logic.

- `ContentViewModel.swift` - Main app state (tabs, navigation, overlay)
- `HomeViewModel.swift` - Home view state and pins
- `SearchViewModel.swift` - Search view state (carousel, boards, sections)
- `ChatViewModel.swift` - Chat view state (messages, updates)
- `ProfileViewModel.swift` - Profile view state (search, tabs)

### Services/
Data services and business logic.

- `DataService.swift` - Data service protocol and mock implementation

### Design/
Design system and style guide.

- `DesignSystem.swift` - Typography, colors, spacing, corner radius, shadows

### Documentation/
Project documentation and guides.

- `StyleGuide.md` - Complete design style guide
- `FontMigrationSummary.md` - Font migration documentation
- `NavigationGuide.md` - Navigation system guide
- `AppRouterAnalysis.md` - AppRouter pros/cons analysis
- `FolderStructure.md` - This file

### Resources/
Storyboards and other resource files.

- `LaunchScreen.storyboard` - iOS launch screen

## 🎯 Benefits of This Structure

1. **Clear Separation**: Each folder has a specific purpose
2. **Easy Navigation**: Find files quickly by their category
3. **Scalability**: Easy to add new files in the right place
4. **Maintainability**: Related files are grouped together
5. **Team Collaboration**: Clear structure for multiple developers

## 📝 Adding New Files

### Adding a New View
- **Main tab view**: Add to `Views/Main/`
- **Detail screen**: Add to `Views/Detail/`
- **Settings screen**: Add to `Views/Settings/`
- **Launch screen**: Add to `Views/Launch/`

### Adding a New Component
- Add to `Components/` folder
- Group related components in the same file (e.g., `CardComponents.swift`)

### Adding a New Model
- Add to `Models/` folder
- One model per file

### Adding a New ViewModel
- Add to `ViewModels/` folder
- One view model per file

### Adding a New Service
- Add to `Services/` folder
- Group related services in the same file if they're small

## 🔄 Migration Notes

This structure was reorganized from a flatter structure to improve organization:
- ✅ Moved `pinterestApp.swift` and `ContentView.swift` to `Core/`
- ✅ Organized views into subfolders by purpose
- ✅ Moved `LaunchScreen.storyboard` to `Resources/`
- ✅ Extracted `HomeView` and `CreateView` from `ContentView.swift`

