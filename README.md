# RGB Nexus // Custom PC Builder & Shop

RGB Nexus is a premium, high-fidelity Flutter mobile application designed for custom PC building enthusiasts and hardware shoppers. Built with a futuristic cyber-aesthetic, it features custom neon visuals, fluid animations, responsive layouts, and robust reactive state management.

---

## 🚀 Key Features

1. **Intelligent PC Customizer**: Choose compatible components (CPU, Motherboard, RAM, GPU, Storage, PSU, Chassis) with real-time price accumulation and integrated compatibility rules checks.
2. **Dynamic Product Catalog**: Browse over 140+ premium tech products mapped to real category-specific images, sorted by rating, category, or search filters.
3. **Reactive Shopping Cart & Checkout**: Add, edit, remove items, review totals including tax, shipping, promo code codes, and place orders in a smooth mock flow.
4. **Order History**: Track past ordered builds and list specific component lines directly from the user profile.
5. **Interactive Support Chat**: Instantly connect with Cyber-Assistant V3 with typing indicators and automated context-aware support replies.
6. **Repair Scheduler & Timeline Tracker**: Book physical PC repaste and repair diagnostic slots, generating a custom ticket code to monitor statuses.
7. **Store Location Map**: Explore branch locations, opening hours, and real-time stocks overlayed on an interactive custom map layout.
8. **Saved Build Configurations**: Name and save multiple PC builds, load them directly back into the Customizer, or delete outdated rigs.

---

## 🛠️ Tech Stack & Architecture

- **Core**: Flutter & Dart (100% Client-Side Static Flow)
- **Routing**: `go_router` (Structured URL paths, deep arguments mapping, and parameter safety)
- **State Management**: `Provider` + `ChangeNotifier` (App-wide unified state reactivity)
- **Styling**: Cyberpunk Theme System (`AppTheme` + `AppColors` for neon cyan/magenta/green palettes)
- **Indentation & Formatting**: Consistent spaces with zero analyze errors/warnings.

### Project Directory Structure

```text
lib/
├── components/          # Reusable shell widgets (CyberDrawer)
├── data/                # Data layers (MockRepository, ProductRepository)
├── theme/               # Theme colors, fonts, and dark mode configs
├── state/               # AppStateNotifier (State lifecycle, Favorites, Cart)
└── features/            # Feature-based modular structure
    ├── auth/            # Start screen, Login, Register, Forgot Password flows
    ├── booking/         # Repair Scheduling & diagnostic bookings
    ├── chat/            # Live support assistant chat thread
    ├── checkout/        # Cart list, Checkout totals, Order Success receipts
    ├── gallery/         # Build Showcase showcase with video tutorials
    ├── home/            # Dashboard, Deals, Compare page, About Us, Help/Support
    ├── map/             # Interactive Store Locations
    ├── pc_builder/      # Shop product grid and Interactive PC Customizer
    ├── services/        # Service listings and ticket timeline tracker
    └── user/            # Profile panel and Order History logs
```

---

## 🎬 Animations & Accessibility

- **Immersive Page Transitions**: Custom slide-in (right-to-left) and fade animations implemented directly in the GoRouter setup for a native look.
- **Micro-interactions**: Pulse image loading placeholders (`ShimmerSkeleton`) in the shop grid, countdown clocks on the Deals screen, and slide-up card entry animations.
- **Accessibility**: Standardized `Semantics` tags wrapped on product action items, along with contextual `tooltip` popups on all core action buttons.
- **Responsiveness**: Grid layouts automatically adjust cross-axis item counts based on device widths using fluid `LayoutBuilder` boundaries.

---

## 💻 How to Build & Run

### Prerequisites

- Flutter SDK (Channel stable)
- Dart SDK
- Android Studio / VS Code with Flutter extension installed

### Steps to Run

1. Clone the repository and checkout the `main` branch:
   ```bash
   git checkout main
   ```
2. Get project dependencies:
   ```bash
   flutter pub get
   ```
3. Run static analyzer to confirm code quality:
   ```bash
   flutter analyze
   ```
4. Build and run the app on a connected emulator or physical device:
   ```bash
   flutter run
   ```