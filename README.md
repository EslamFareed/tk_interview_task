# TK Interview Task

A Flutter application that displays the iTunes Top 100 Albums feed, built with Clean Architecture and BLoC state management.

## Features

- Fetches and displays the iTunes Top 100 Albums
- Album detail view with full information
- Dark theme UI with cached network images
- Clean Architecture (data / domain / presentation layers)
- BLoC pattern for state management

## Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.x** (Dart SDK `^3.9.2`)
- Android Studio / Xcode (for emulator/simulator), **or** a physical device

Verify your environment:

```bash
flutter doctor
```

## Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd tk_interview_task
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

**On a connected device or emulator:**

```bash
flutter run
```

**Target a specific platform explicitly:**

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

## Running Tests

```bash
flutter test
```

## Building a Release APK (Android)

```bash
flutter build apk --release
```

The output APK will be located at:

```
build/app/outputs/flutter-apk/app-release.apk
```

## Project Structure

```
lib/
├── core/               # Theme and shared constants
├── data/
│   ├── datasources/    # Remote API calls (iTunes RSS feed)
│   ├── models/         # JSON serialization models
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Core business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Use case definitions
└── presentation/
    ├── bloc/           # BLoC events, states, and logic
    ├── pages/          # Albums list and detail pages
    └── widgets/        # Reusable UI widgets
```

## Dependencies

| Package                | Purpose                           |
| ---------------------- | --------------------------------- |
| `flutter_bloc`         | State management                  |
| `http`                 | Network requests                  |
| `cached_network_image` | Efficient image loading & caching |
| `equatable`            | Value equality for BLoC states    |
