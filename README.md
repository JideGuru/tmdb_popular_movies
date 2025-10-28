# tmdb_popular_movies

A Flutter application that displays popular movies from The Movie Database (TMDB) API.

## Preview

[preview/tmdb-1-comp.mp4](preview/tmdb-1-comp.mp4)

## Features

- Browse popular movies
- Search for movies with real-time results
- View movie details
- Pagination support for both popular and search results

## Setup

### Prerequisites

- Flutter SDK
- TMDB API Key (get one from [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api))

### API Key Configuration

This app uses `--dart-define` to securely pass the TMDB API key at build/run time.

## Running the App

### Command Line

Run the app with your API key:

```bash
flutter run --dart-define=TMDB_API_KEY=your_api_key_here
```

### Build APK

```bash
flutter build apk --dart-define=TMDB_API_KEY=your_api_key_here
```

### Build iOS

```bash
flutter build ios --dart-define=TMDB_API_KEY=your_api_key_here
```

### Android Studio / IntelliJ IDEA

1. Go to **Run > Edit Configurations**
2. Select your run configuration
3. In the **Additional run args** field, add:
   ```
   --dart-define=TMDB_API_KEY=your_api_key_here
   ```
4. Click **Apply** and **OK**

## Project Structure

```
lib/
├── common/              # Common utilities, theme, and API client
├── features/
│   └── movies/
│       ├── bloc/        # State management (Cubits)
│       ├── data/        # Data layer (repositories)
│       ├── domain/      # Domain models
│       └── presentation/ # UI layer (pages and widgets)
└── main.dart
```

## Architecture

This project follows a clean architecture pattern with:
- **BLoC/Cubit** for state management
- **Repository pattern** for data access
- **Feature-based** folder structure
