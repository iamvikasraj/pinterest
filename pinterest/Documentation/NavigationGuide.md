# Navigation Guide

## Overview

The app now supports in-page navigation using SwiftUI's `NavigationStack` with a type-safe routing system. This allows navigation from any view to detail screens while maintaining the MVVM architecture.

## Architecture

### 1. **Route Enum** (`Models/Route.swift`)
Type-safe routes for all navigation destinations:
```swift
enum Route: Hashable {
    case pinDetail(pinId: String)
    case boardDetail(boardId: String)
    case userProfile(userId: String)
    case messageDetail(messageId: String)
    case settings
    case editProfile
    case searchResults(query: String)
}
```

### 2. **ContentViewModel** (`ViewModels/ContentViewModel.swift`)
Manages navigation state:
- `navigationPath: NavigationPath` - Tracks navigation stack
- `navigate(to:)` - Navigate to a route
- `navigateBack()` - Go back one screen
- `navigateToRoot()` - Return to root

### 3. **NavigationStack** (`ContentView.swift`)
Wraps all tab content in a `NavigationStack` that handles routing.

## Usage Examples

### From a Card Component

```swift
PinCard(
    pin: pin,
    onMoreTapped: {
        // Show overlay
    },
    onPinTapped: { pinId in
        contentViewModel.navigate(to: .pinDetail(pinId: pinId))
    }
)
```

### From a View

```swift
struct MyView: View {
    var onNavigate: ((Route) -> Void)? = nil
    
    var body: some View {
        Button("View Pin") {
            onNavigate?(.pinDetail(pinId: "123"))
        }
    }
}
```

### In TabContentView

```swift
case .home:
    HomeView(viewModel: viewModel) // Has access to viewModel
case .search:
    SearchView(onNavigate: { route in
        viewModel.navigate(to: route)
    })
```

## Navigation Flow

1. **User taps** a card/button
2. **Component calls** `onPinTapped` / `onNavigate` callback
3. **View calls** `viewModel.navigate(to: route)`
4. **NavigationStack** automatically pushes the destination view
5. **User can navigate back** using the back button

## Adding New Routes

1. **Add route to `Route` enum:**
```swift
case newScreen(id: String)
```

2. **Add destination in `ContentView.destinationView`:**
```swift
case .newScreen(let id):
    NewScreenView(id: id)
```

3. **Navigate from anywhere:**
```swift
viewModel.navigate(to: .newScreen(id: "123"))
```

## Current Navigation Support

✅ **HomeView** → Pin Detail (via PinCard tap)
✅ **SearchView** → Board Detail (via FeaturedBoardCard tap)
✅ **ChatView** → Message Detail (via MessageCard tap)
✅ **ProfileView** → Settings (via header button)

## Best Practices

1. **Always pass navigation handler** to child views that need navigation
2. **Use type-safe routes** instead of strings
3. **Clear navigation path** when switching tabs (already implemented)
4. **Keep navigation logic** in ViewModels, not Views
5. **Use optional callbacks** for flexibility

## Example: Complete Navigation Flow

```swift
// 1. Component
PinCard(
    pin: pin,
    onPinTapped: { pinId in
        onNavigate?(.pinDetail(pinId: pinId))
    }
)

// 2. View
HomeView(viewModel: contentViewModel)
// Has direct access to contentViewModel

// 3. ViewModel
contentViewModel.navigate(to: .pinDetail(pinId: pinId))

// 4. NavigationStack automatically shows PinDetailView
```

