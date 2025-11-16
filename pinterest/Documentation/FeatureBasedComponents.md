# Feature-Based Component Organization

## 🎯 Overview

Components are now organized by **feature** rather than by component type. This makes it easier to find and maintain feature-specific UI components.

## 📁 Structure

```
Components/
├── Home/                    # Home feature components
│   ├── PinCard.swift
│   └── PinCardFramePreferenceKey.swift
│
├── Search/                  # Search feature components
│   ├── HeroCarousel.swift
│   ├── SearchBar.swift
│   ├── SearchSections.swift
│   └── FeaturedBoardCard.swift
│
├── Chat/                    # Chat feature components
│   └── ChatCards.swift      # MessageCard, UpdateCard
│
├── Profile/                 # Profile feature components
│   ├── ProfileSearchBar.swift
│   └── NavigationTab.swift
│
└── Shared/                  # Shared components (used across features)
    ├── BottomNavigation.swift    # BottomNavigationView, TabButton
    ├── CreateBottomSheet.swift
    ├── PinDetailSheet.swift
    ├── OverlayComponents.swift    # BottomOverlayView, OverlayOptionRow
    └── UtilityComponents.swift    # UserProfileImage, RoundedCorner, etc.
```

## 🗺️ Component Mapping

### Home Feature
- **PinCard** - Displays pin images in the home grid
- **PinCardFramePreferenceKey** - Tracks pin card frame for animations

### Search Feature
- **HeroCarousel** - Main carousel at top of search screen
- **SearchBar** - Search input bar
- **SearchSections** - FeaturedBoardView, SearchSectionView
- **FeaturedBoardCard** - Board card in featured section

### Chat Feature
- **ChatCards** - MessageCard, UpdateCard

### Profile Feature
- **ProfileSearchBar** - Search bar with expandable content
- **NavigationTab** - Tab navigation for profile sections

### Shared Components
- **BottomNavigation** - BottomNavigationView, TabButton (used across all tabs)
- **CreateBottomSheet** - Create options sheet
- **PinDetailSheet** - Pin detail bottom sheet
- **OverlayComponents** - BottomOverlayView, OverlayOptionRow
- **UtilityComponents** - UserProfileImage, RoundedCorner, ScrollOffsetPreferenceKey, View extensions

## 🎯 Benefits

1. **Feature Cohesion**: All components for a feature are together
2. **Easier Navigation**: Find components by feature, not type
3. **Better Maintainability**: Feature changes stay in one place
4. **Clear Ownership**: Know which feature owns which components

## 📝 Usage Examples

### Home Feature
```swift
import SwiftUI

// In HomeView.swift
PinCard(
    pin: pin,
    onMoreTapped: { ... },
    onPinTapped: { ... }
)
```

### Search Feature
```swift
// In SearchView.swift
HeroCarousel(viewModel: viewModel)
SearchBar()
FeaturedBoardView(...)
SearchSectionView(...)
```

### Chat Feature
```swift
// In ChatView.swift
MessageCard(message: message, onMessageTapped: { ... })
UpdateCard(update: update)
```

### Profile Feature
```swift
// In ProfileView.swift
ProfileSearchBar(viewModel: viewModel, isTextFieldFocused: $isFocused)
NavigationTab(title: "Pins", isSelected: true, onTap: { ... })
```

### Shared Components
```swift
// In ContentView.swift
BottomNavigationView(viewModel: contentViewModel)
```

## 🔄 Migration Notes

Components were reorganized from type-based to feature-based:
- ✅ `Components/Cards/` → Split into `Home/`, `Search/`, `Chat/`
- ✅ `Components/Navigation/` → Split into `Shared/` and `Profile/`
- ✅ `Components/Search/` → Moved to `Search/` and `Profile/`
- ✅ `Components/Sheets/` → Moved to `Shared/`
- ✅ `Components/Utilities/` → Split into feature folders and `Shared/`

