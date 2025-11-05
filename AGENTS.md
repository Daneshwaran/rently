# Rently - Agent Guidelines

## Commands
- **Test**: `flutter test` (all tests), `flutter test test/widget_test.dart` (single file)
- **Analyze**: `flutter analyze` (lint/static analysis)
- **Build**: `flutter build apk` (Android), `flutter build ios` (iOS)
- **Run**: `flutter run` (with device connected or emulator)
- **Code generation**: `flutter pub run build_runner build --delete-conflicting-outputs`

## Architecture
- **Clean Architecture**: Domain (entities, repositories, usecases) → Application (providers, usecases) → Infrastructure (datasources, models, repositories) → Presentation (pages, widgets, router)
- **State Management**: Riverpod with `flutter_riverpod`, code generation via `riverpod_generator`
- **Navigation**: GoRouter (`go_router`)
- **Database**: Cloud Firestore (Firebase)
- **Entities**: Freezed for immutable models with JSON serialization

## Code Style
- **Imports**: Package imports first, then relative imports using `../../` pattern
- **Widgets**: Prefer `ConsumerWidget` for Riverpod, use `const` constructors where possible
- **Naming**: camelCase for variables/methods, PascalCase for classes, snake_case for files
- **State**: Use `ref.watch()` in build, `ref.read()` in callbacks
- **Generated files**: Run build_runner after modifying `@freezed` or `@JsonSerializable` classes
- **Error handling**: Use `AsyncValue.when()` for async state (data/loading/error)
