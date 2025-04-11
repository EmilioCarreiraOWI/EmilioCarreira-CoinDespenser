# EmilioCarreira-CoinDespenser

The goal of the Coin Dispense System is to calculate a cash amount captured for the total purchase price of a transaction, and the system returns a displayed breakdown value of notes and coins to be dispensed.

## Features

- Calculates the exact breakdown of notes and coins for a given transaction.
- Cross-platform support (Android, iOS, macOS, Windows, Linux, Web).
- Modular architecture for scalability and maintainability.
- Dependency injection for managing services and cubits.
- Platform-specific configurations for optimized performance.

## Extensions and Tools Used

This project utilizes the following extensions and tools:

- **Flutter Lints**: Enforces best practices and coding standards.
- **Dependency Injection**: Managed using a custom `DependencyInjection` class located in `lib/core/dependancy_injection.dart`.
- **Platform-Specific Configurations**:
  - Android: Configured via `build.gradle.kts` and `settings.gradle.kts`.
  - iOS/macOS: Configured via Xcode project files and `.xcconfig` files.
  - Windows/Linux: Configured via `CMakeLists.txt`.
  - Web: Configured via `manifest.json` and `index.html`.

