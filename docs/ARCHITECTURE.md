# Stylo - Technical Architecture Document

**Project:** Stylo
**Description:** Simple fashion online shop with an AI try-on feature, giving users a sense of what items would look like on them.
**Target Region:** Indonesia
**Platform:** Cross-platform mobile (iOS & Android) via Flutter

---

## 1. Architecture & App Structure

### Architecture Pattern: Feature-Driven Clean Architecture

The application is organized into distinct **feature modules**, each self-contained with its own layers. This promotes separation of concerns, testability, and scalability.

```
lib/
├── app/                          # App-level configuration
│   ├── app.dart                  # Root MaterialApp / GoRouter setup
│   └── di/                       # Dependency injection setup (get_it)
│       └── injection_container.dart
│
├── core/                         # Shared code across all features
│   ├── constants/                # App-wide constants (API URLs, keys)
│   ├── errors/                   # Custom exceptions and failure classes
│   ├── network/                  # HTTP client setup, interceptors
│   ├── theme/                    # App theme, colors, text styles
│   ├── utils/                    # Shared utility functions
│   └── widgets/                  # Reusable UI components
│
├── features/                     # Feature modules
│   ├── auth/                     # Authentication feature
│   │   ├── data/
│   │   │   ├── datasources/      # Remote & local data sources
│   │   │   ├── models/           # Freezed data models + JSON serialization
│   │   │   └── repositories/     # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/         # Core business entities
│   │   │   ├── repositories/     # Repository interfaces (abstract classes)
│   │   │   └── usecases/         # Business logic use cases
│   │   └── presentation/
│   │       ├── bloc/             # BLoC state management
│   │       ├── pages/            # Full-screen pages/screens
│   │       └── widgets/          # Feature-specific widgets
│   │
│   ├── home/                     # Home / product browsing feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── product/                  # Product detail & catalog feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── ai_try_on/                # AI Try-On feature (key feature)
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── cart/                     # Shopping cart feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── checkout/                 # Checkout & payment feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── orders/                   # Order history & tracking feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── profile/                  # User profile & settings feature
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart                     # Entry point
```

### Layering (per feature)

Each feature module follows strict **Clean Architecture** layers:

| Layer | Directory | Responsibility |
|---|---|---|
| **Data** | `data/` | Repository implementations, remote/local data sources, freezed models with JSON serialization |
| **Domain** | `domain/` | Pure business logic — entities, repository interfaces (abstract classes), and use cases |
| **Presentation** | `presentation/` | UI widgets, pages, and BLoC state management |

**Dependency Rule:** Dependencies point inward. `presentation` depends on `domain`, `data` depends on `domain`. The `domain` layer has zero dependencies on Flutter or external packages.

---

## 2. Core Libraries & State Management

| Purpose | Package | Notes |
|---|---|---|
| **State Management** | `flutter_bloc` | Predictable state management using the BLoC pattern. Each feature has its own BLoC(s). |
| **State Equivalence** | `equatable` | Paired with BLoC to enable value-based equality checks and minimize unnecessary widget rebuilds. |
| **Dependency Injection** | `get_it` | Service Locator pattern. Registers repositories, data sources, and BLoCs at app startup. |
| **Reactive Programming** | `rxdart` | Extends standard Dart Streams with operators like `debounceTime`, `switchMap`, `combineLatest` for complex async flows. |
| **Routing** | `go_router` | Declarative, deep-link-friendly routing. Supports nested navigation, redirects, and route guards for auth. |

### BLoC Architecture

```
UI Event → BLoC → Use Case → Repository → Data Source
                                              ↓
UI ← BLoC State ← (transformed result) ← Response
```

- **Events:** Immutable objects describing user actions or system triggers.
- **States:** Immutable objects representing the current UI state. Uses `equatable` for efficient comparison.
- **BLoCs:** Orchestrate use cases and emit new states in response to events.

---

## 3. Data & Persistence

| Purpose | Package | Notes |
|---|---|---|
| **Data Classes & Immutability** | `freezed`, `freezed_annotation` | Generates immutable data classes with `copyWith`, union types, and pattern matching. |
| **JSON Serialization** | `json_serializable`, `json_annotation` | Auto-generates `fromJson`/`toJson` methods. Maps API responses to freezed models. |
| **Local Database** | `drift` | Reactive, type-safe SQL database for Flutter. Built on SQLite with code generation, streaming queries, and offline-first capabilities. Replaces Realm due to `source_gen` version conflicts. |
| **Simple Storage** | `shared_preferences` | Lightweight key-value storage for tokens, user preferences, and simple settings. |

### Data Flow

```
Remote API  ──→  Remote Data Source  ──→  Repository  ──→  Use Case  ──→  BLoC
                                              ↕
Drift DB    ──→  Local Data Source   ──→  Repository (cache/offline fallback)
```

### Offline-First Strategy

1. **Read:** Check Drift/SQLite cache first. If data is stale or missing, fetch from remote API and update local DB.
2. **Write:** Write to Drift locally first. Sync to remote API when connectivity is restored.
3. **Connectivity:** `connectivity_plus` monitors network state and triggers sync operations.

---

## 4. Device Native Capabilities

| Purpose | Package | Notes |
|---|---|---|
| **GPS/Location** | `geolocator` | Access device GPS for location-based features (e.g., nearby stores, delivery estimation). |
| **Background Services** | `flutter_background_service` | Execute operations when the app is minimized or closed (e.g., order sync, notification handling). |
| **Network State** | `connectivity_plus` | Detect online/offline status. Drives the offline-first data sync strategy with Drift. |

---

## 5. Maps & UI Components

| Purpose | Package | Notes |
|---|---|---|
| **Mapping** | `flutter_map` + `latlong2` | Leaflet-based maps for Flutter. Used for store locators, delivery tracking. `latlong2` handles coordinate math. |
| **Typography** | `google_fonts` | Access to the full Google Fonts catalog. Enables consistent, brand-aligned typography. |
| **Image Handling** | `cached_network_image` | Downloads, caches, and displays network images with placeholder and error widgets. |
| **Loading Effects** | `shimmer` | Skeleton loading screens that provide visual feedback while data is being fetched. |
| **App Walkthrough** | `showcaseview` | Targeted highlight bubbles for user onboarding and feature discovery. |

---

## 6. Helpful Utilities & Dev Tools

| Purpose | Package | Notes |
|---|---|---|
| **Unique IDs** | `uuid` | Generate unique identifiers for local entities before server sync. |
| **Formatting** | `intl` | Date, currency (IDR), and number formatting. Supports Indonesian locale (`id_ID`). |
| **Code Generation** | `build_runner` | Powers `freezed`, `json_serializable`, and potential `get_it` injection generation. |
| **Linting** | `flutter_lints` | Enforces consistent code style and catches common issues at compile time. |

### Code Generation Workflow

```bash
# Run code generation (one-time)
dart run build_runner build --delete-conflicting-outputs

# Run code generation (watch mode during development)
dart run build_runner watch --delete-conflicting-outputs
```

---

## 7. Dependency Summary

### Runtime Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management & DI
  flutter_bloc:
  equatable:
  get_it:
  rxdart:

  # Routing
  go_router:

  # Data & Serialization
  freezed_annotation:
  json_annotation:
  drift:
  sqlite3_flutter_libs:
  shared_preferences:
  connectivity_plus:

  # Device Capabilities
  geolocator:
  flutter_background_service:

  # Maps & UI
  flutter_map:
  latlong2:
  google_fonts:
  cached_network_image:
  shimmer:
  showcaseview:

  # Utilities
  uuid:
  intl:
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints:
  build_runner:
  freezed:
  json_serializable:
  drift_dev:
```

---

## 8. Project Bootstrap

```bash
flutter create stylo
cd stylo

# Add core dependencies
flutter pub add flutter_bloc equatable get_it go_router freezed_annotation json_annotation drift sqlite3_flutter_libs connectivity_plus shared_preferences

# Add device capabilities
flutter pub add geolocator flutter_background_service

# Add UI and utility dependencies
flutter pub add flutter_map latlong2 google_fonts cached_network_image shimmer showcaseview uuid rxdart intl

# Add dev dependencies
flutter pub add dev:build_runner dev:freezed dev:json_serializable dev:drift_dev dev:flutter_lints
```

---

## 9. Key Feature: AI Try-On

The AI Try-On feature is the core differentiator of Stylo. It allows users to upload a photo of themselves and virtually "try on" clothing items from the catalog.

### AI Try-On Flow

```
User Photo Upload → Image Processing → AI Model (Backend API) → Composite Result → Display to User
```

### Architecture Considerations

- **Backend-Driven:** The AI processing (virtual try-on model) runs on a backend server, not on-device. The mobile app sends the user photo and selected product to the API and receives the composite result.
- **Privacy:** User photos are processed and discarded after generation. Clear consent flows are implemented per Indonesian data protection regulations.
- **Caching:** Generated try-on results are cached locally in Drift/SQLite for quick revisit without re-processing.

---

## 10. Localization & Regional Considerations

- **Primary Language:** Bahasa Indonesia (`id`)
- **Currency:** Indonesian Rupiah (IDR), formatted via `intl` with `id_ID` locale
- **Date/Time:** Indonesian locale formatting
- **Payment Gateways:** Integration-ready for Indonesian payment providers (e.g., GoPay, OVO, Dana, bank transfers)
