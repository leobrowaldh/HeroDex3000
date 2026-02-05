# HeroDex 3000
A cross‑platform Flutter application for browsing, saving, and managing hero data, built with a focus on stability, maintainability, and clear architectural boundaries.

HeroDex 3000 runs on mobile, tablet, and web. It uses Firebase for authentication and data storage, integrates optional analytics and crash reporting, and provides a structured onboarding flow that respects user privacy choices.

---

## Overview
HeroDex 3000 allows users to:

- Authenticate with Firebase
- Search for heroes via an external API
- View detailed hero information
- Save heroes to a personal collection
- Manage privacy and appearance settings
- Navigate through a clean, responsive UI

The project is structured to support long‑term maintainability and predictable behavior across platforms.

---

## Features

### Onboarding
- Intro screen explaining the app
- User‑controlled privacy options:
  - Analytics (enabled/disabled)
  - Crash Reporting (enabled/disabled)
- iOS‑only App Tracking Transparency (ATT) pre‑prompt
- All preferences stored locally and respected throughout the app

### Authentication
- Email/password login
- Account creation
- Password reset
- Auth‑guarded navigation

### Home
- Displays number of saved heroes
- Displays total fighting power
- Shows general “invasion status” information

### Search
- Search heroes via API
- Debounced input
- Reusable card UI
- Detailed hero view
- Save heroes to Firestore/local storage

### Saved Heroes
- List of saved heroes
- Swipe‑to‑delete
- Persistent storage

### Settings
- Dark/Light mode
- High contrast mode
- Privacy settings (analytics, crash reporting)
- ATT status (iOS only)
- App information (version, creator, year)

---

## Onboarding and Privacy
HeroDex 3000 is designed so that user choices directly control data behavior:

- Analytics only runs when explicitly enabled
- Crash reporting only runs when explicitly enabled
- ATT is requested only on iOS and only once
- All services check user preferences before performing any external operations

This ensures predictable and transparent data handling.

---

## Architecture
The application follows a feature‑based structure with clear separation between UI, state, and side effects.

```
lib/
 ├─ features/
 │   ├─ onboarding/
 │   ├─ auth/
 │   ├─ home/
 │   ├─ search/
 │   ├─ heroes/
 │   └─ settings/
 ├─ services/
 ├─ cubits/
 ├─ router/
 ├─ widgets/
 └─ main.dart
```

### Architectural principles
- Feature‑oriented organization
- Separation of concerns
- Stateless UI components
- Cubit for predictable state transitions
- Services for external interactions
- Dependency injection for testability and modularity

---

## State Management
The app uses **Cubit** from `flutter_bloc` for:

- Onboarding
- Authentication
- Settings
- Search
- Saved heroes

Each Cubit is responsible for a single domain, keeping logic isolated and testable.

---

## Navigation
Navigation is implemented using **go_router**, providing:

- Auth‑guarded routes
- Nested navigation
- Tab navigation
- Clear, declarative route definitions

Example flow:

```
Onboarding → Login → Home (Tabs)
```

---

## Data Sources
- External Hero API
- Firebase Firestore
- Firebase Authentication
- Local storage for onboarding preferences

---

## Stability and Error Handling
The app is structured to avoid runtime crashes through:

- Centralized error handling
- Predictable state transitions
- Defensive service layers
- UI that does not assume data availability
- Null‑safe codebase

The goal is consistent behavior across all platforms, even under adverse conditions.

---

## Testing
The project includes automated tests (e.g., AuthRepository tests) using mocks for:

- FirebaseAuth
- AnalyticsService
- CrashlyticsService

The architecture supports expanding test coverage without restructuring.

---

## Design and UX
Design choices emphasize:

- Consistent spacing and typography
- Reusable UI components
- Clear visual hierarchy
- Support for high contrast mode
- Scalable text and semantic labels

The UI is intentionally minimal and functional to support multiple platforms.

---

## Technologies Used

### Flutter & Dart
Cross‑platform UI framework.

### Firebase
- Authentication
- Firestore
- Analytics
- Crashlytics

### Packages
- go_router
- flutter_bloc
- firebase_*
- app_tracking_transparency
- flutter_native_splash
- flutter_launcher_icons

---

## Running the App

Install dependencies:
```
flutter pub get
```

Run on device:
```
flutter run
```

Build for release:
```
flutter build apk
flutter build ios
```

---

## Project Structure
```
features/
  onboarding/
  auth/
  home/
  search/
  heroes/
  settings/
services/
cubits/
router/
widgets/
```

---

## License
This project was created as part of the *Application Development with Dart/Flutter* course.