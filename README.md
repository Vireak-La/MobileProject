# RGB Nexus // Custom PC Builder & Premium Shop

RGB Nexus is a premium, high-fidelity Flutter mobile application designed for custom PC building enthusiasts and hardware shoppers. Built with a futuristic cyber-aesthetic, it features custom neon visuals, fluid animations, responsive layouts, and robust reactive state management.

---

## 🚀 Key Features

1. **Intelligent PC Customizer (Configuration Wizard)**:
   - Choose compatible components across 7 categories (CPU, Motherboard, RAM, GPU, Storage, PSU, Chassis).
   - Real-time estimated price accumulation.
   - Built-in compatibility rule validations (CPU Socket matching, minimum PSU guidelines based on CPU+GPU estimated TDP).
   - Save custom rig build profiles directly to local memory or load them back into the builder dynamically.

2. **Vast Static Product Catalog**:
   - Mapped with real-looking category-specific network images.
   - 7 categories × 20 premium components = 140 products in database.
   - Live rating metrics, product specs, and detailed descriptions.

3. **Reactive Shopping Cart & Checkout**:
   - Full cart management (add, edit quantities, remove items, clear cart).
   - Subtotal, 8% tax, free shipping above $1,200 threshold, or $24.99 standard shipping.
   - Fully static simulated Checkout flow and custom order success receipts showing mock order details.

4. **Timeline Repair & Service Tracker**:
   - Book cleanings, repaste services, and custom diagnostics.
   - Auto-generated 6-digit RGB/PRO tickets to monitor repair progression (Timeline states: Received, Diagnostics, Parts Sourcing, Repairing, Testing, Ready for Pickup).

5. **Store Locations Interactive Map**:
   - High-fidelity interactive local branches map featuring coordinates overlay, distance estimations, hours, and available stock levels.

6. **Interactive Support Chat**:
   - Automated replies detecting key terms (hours, compatible, repair, prices) with custom typing delay and dynamic response bubbles.

7. **Community Setup Showcases**:
   - Interactive comment feeds and likes toggle on custom PC builds and gaming spaces shared by local user setups.

---

## 🛠️ Tech Stack & Architecture

- **Core Framework**: Flutter & Dart (Static client-side data workflow, 100% offline-ready).
- **Navigation & Routing**: `go_router` (parameter-safe structured URLs, parameter passing via state.extra, page transitions configuration).
- **State Management**: `Provider` + `ChangeNotifier` (`AppStateNotifier` handles app states including Cart, Tickets, Saved Builds, User Profile, Chat, and Navigation history).
- **Theme design system**: Custom Cyberpunk UI (`AppTheme` and `AppColors` targeting electric cyan, neon magenta, neon green, and deep slate/graphite card surfaces).

### Project Directory Structure

```text
lib/
├── components/          # Reusable shell widgets (CyberDrawer)
├── data/                # MockRepository, ProductRepository (140 static products)
├── theme/               # Theme colors, fonts, and dark mode configs
├── state/               # AppStateNotifier (Reactivity lifecycle, Cart state)
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

- **Immersive Page Transitions**: Page-by-page custom slide-in (right-to-left) and fade animations implemented directly in the GoRouter setup for a native look.
- **Micro-interactions**: Countdown timer on Deals and Home hot-deals screen updating statefully, hero image parallax fade-in.
- **Accessibility**: Tooltips on all core navigation/icon buttons.
- **Responsiveness**: Grid layouts automatically adjust cross-axis item counts based on device widths.

---

## 💻 How to Build & Run

### Prerequisites

- Flutter SDK (Channel stable)
- Dart SDK
- Android Studio / VS Code with Flutter extension installed

### Steps to Run

1. Clone the repository and checkout the `main` branch:
   ```bash
   git clone <repo-url>
   cd mobileproject
   git checkout main
   ```
2. Fetch all packages and dependencies:
   ```bash
   flutter pub get
   ```
3. Confirm code quality using static analysis:
   ```bash
   flutter analyze
   ```
4. Launch the application on a connected device/emulator:
   ```bash
   flutter run
   ```