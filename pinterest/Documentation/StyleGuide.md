# Pinterest App Design Style Guide

## Typography System

All fonts use **SF Pro** (iOS system font) for consistency and native feel.

### Display Styles
Used for large, prominent text like page titles and hero sections.

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `Display.large` | 32pt | Bold | Main hero titles |
| `Display.medium` | 28pt | Bold | Secondary hero titles |
| `Display.small` | 24pt | Bold | Section headers, search titles |

### Title Styles
Used for section headers and important labels.

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `Title.large` | 20pt | Medium | Page titles, carousel subtitles |
| `Title.medium` | 18pt | Medium | Subsection headers |
| `Title.small` | 16pt | Medium | Section headers |

### Body Styles
Used for main content text.

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `Body.large` | 16pt | Regular | Search placeholders, main content |
| `Body.medium` | 15pt | Regular | Card content, message previews |
| `Body.small` | 14pt | Regular | Card titles, smaller content |

### Caption Styles
Used for secondary information, timestamps, and metadata.

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `Caption.large` | 12pt | Regular | Timestamps, stats, categories |
| `Caption.medium` | 11pt | Regular | Fine print |
| `Caption.small` | 10pt | Regular | Very small text |

### Label Styles
Used for interactive elements and emphasized text.

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `Label.large` | 16pt | Semibold | Section titles, buttons |
| `Label.medium` | 15pt | Semibold | Navigation items, card labels |
| `Label.small` | 14pt | Semibold | Small labels |

### Semantic Styles (Pre-configured Common Use Cases)

| Style | Size | Weight | Usage |
|-------|------|--------|-------|
| `Semantic.pageTitle` | 20pt | Semibold | Page headers (Inbox, Settings) |
| `Semantic.sectionTitle` | 16pt | Semibold | Section headers (Messages, Updates) |
| `Semantic.subsectionTitle` | 14pt | Medium | Subsection headers |
| `Semantic.cardTitle` | 14pt | Medium | Card titles, board titles |
| `Semantic.cardBody` | 15pt | Regular | Card content text |
| `Semantic.cardCaption` | 12pt | Regular | Card metadata, timestamps |
| `Semantic.navTitle` | 20pt | Semibold | Navigation bar titles |
| `Semantic.navItem` | 15pt | Semibold | Navigation tab items |
| `Semantic.tabLabel` | 15pt | Semibold | Bottom tab labels |
| `Semantic.searchPlaceholder` | 16pt | Regular | Search bar placeholders |
| `Semantic.searchTitle` | 24pt | Bold | Search page titles |
| `Semantic.carouselTitle` | 14pt | Medium | Carousel item titles |
| `Semantic.carouselSubtitle` | 20pt | Medium | Carousel item subtitles |
| `Semantic.overlayOption` | 16pt | Regular | Bottom overlay menu options |

---

## Color System

### Brand Colors
- **Pinterest Red**: `Color(red: 0.85, green: 0.0, blue: 0.0)` - `AppColors.pinterestRed`

### Text Colors
- **Primary**: `Color.black` - `AppColors.textPrimary`
- **Secondary**: `Color(red: 0.39, green: 0.39, blue: 0.38)` - `AppColors.textSecondary`
- **Tertiary**: `Color(red: 0.59, green: 0.57, blue: 0.57)` - `AppColors.textTertiary`

### Background Colors
- **Primary**: `Color.white` - `AppColors.backgroundPrimary`
- **Secondary**: `Color(red: 0.91, green: 0.9, blue: 0.88)` - `AppColors.backgroundSecondary`
- **Tertiary**: `Color(red: 0.73, green: 0.73, blue: 0.73)` - `AppColors.backgroundTertiary`

### UI Colors
- **Border Gray**: `Color(red: 0.85, green: 0.85, blue: 0.85)` - `AppColors.borderGray`
- **Indicator Gray**: `Color(red: 0.78, green: 0.78, blue: 0.76)` - `AppColors.indicatorGray`

---

## Spacing System

Consistent spacing values for padding and margins.

| Token | Value | Usage |
|-------|-------|-------|
| `Spacing.xs` | 4pt | Tight spacing, icon padding |
| `Spacing.sm` | 8pt | Small gaps, compact layouts |
| `Spacing.md` | 12pt | Standard spacing |
| `Spacing.lg` | 16pt | Section padding, card spacing |
| `Spacing.xl` | 20pt | Large gaps, section margins |
| `Spacing.xxl` | 24pt | Major section spacing |
| `Spacing.xxxl` | 30pt | Large section spacing |

---

## Corner Radius

| Token | Value | Usage |
|-------|-------|-------|
| `CornerRadius.small` | 8pt | Small cards, buttons |
| `CornerRadius.medium` | 12pt | Medium cards |
| `CornerRadius.large` | 16pt | Large cards, images |
| `CornerRadius.xlarge` | 20pt | Profile images |
| `CornerRadius.round` | 24pt | Bottom sheets, modals |

---

## Shadow Styles

| Token | Color | Radius | Offset | Usage |
|-------|-------|--------|--------|-------|
| `Shadow.small` | Black 10% | 4pt | (0, 2) | Subtle elevation |
| `Shadow.medium` | Black 15% | 8pt | (0, 4) | Card shadows |
| `Shadow.large` | Black 10% | 20pt | (0, -5) | Bottom sheets |

---

## Usage Examples

### Typography
```swift
// Instead of:
Text("Title").font(.system(size: 20, weight: .semibold))

// Use:
Text("Title").font(Typography.Semantic.pageTitle)
```

### Colors
```swift
// Instead of:
Text("Subtitle").foregroundColor(Color(red: 0.39, green: 0.39, blue: 0.38))

// Use:
Text("Subtitle").foregroundColor(AppColors.textSecondary)
```

### Spacing
```swift
// Instead of:
.padding(.horizontal, 16)

// Use:
.padding(.horizontal, Spacing.lg)
```

### Corner Radius
```swift
// Instead of:
.cornerRadius(16)

// Use:
.cornerRadius(CornerRadius.large)
```

---

## Font Size Reference

### Current Font Sizes in Use:
- **32pt** - Display large (bold)
- **28pt** - Display medium (bold) 
- **24pt** - Display small / Search title (bold)
- **20pt** - Page titles, carousel subtitles (semibold/medium)
- **18pt** - Title medium (medium)
- **16pt** - Section titles, search placeholder, labels (semibold/regular)
- **15pt** - Body medium, navigation items (regular/semibold)
- **14pt** - Card titles, subsection titles (medium)
- **12pt** - Captions, timestamps, metadata (regular)
- **11pt** - Caption medium (regular)
- **10pt** - Caption small (regular)

---

## Migration Notes

✅ All "Inter" font references have been replaced with SF Pro (system font)
✅ Font sizes standardized using Typography system
✅ Colors standardized using AppColors system
✅ Design tokens available in `Design/DesignSystem.swift`

