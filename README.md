# kuwe_flutter_starter

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A production-ready Flutter starter brick for generating robust, scalable, feature-first applications with best practices baked in.

---

## Features 🚀

- **Architecture:** Feature-first modular structure with Service Locator pattern ([`get_it`](https://pub.dev/packages/get_it)).
- **State Management:** Predictable state handling using the BLoC pattern ([`flutter_bloc`](https://pub.dev/packages/flutter_bloc)).
- **Routing:** Strongly-typed declarative routing with ([`auto_route`](https://pub.dev/packages/auto_route)).
- **Networking:** HTTP client powered by ([`dio`](https://pub.dev/packages/dio)) with logging ([`pretty_dio_logger`](https://pub.dev/packages/pretty_dio_logger)) and retry handling ([`dio_smart_retry`](https://pub.dev/packages/dio_smart_retry)).
- **Firebase Ecosystem:** Integrated with Firebase Core, Firebase Auth, Cloud Firestore, and Firebase Messaging, plus OneSignal support.
- **Environments:** Pre-configured environment flavors for `development` and `production` with ([`envied`](https://pub.dev/packages/envied)).
- **Localization:** Multi-language support out-of-the-box (English and Turkish sample ARB setups) using Flutter standard localization.
- **Linting & Code Quality:** Strict lint rules enforced via ([`very_good_analysis`](https://pub.dev/packages/very_good_analysis)).
- **Asset Generation:** Type-safe asset management with ([`flutter_gen`](https://pub.dev/packages/flutter_gen)).

---

## Getting Started 🧱

### 1. Install Mason CLI

If you haven't installed Mason CLI yet, install it via `dart pub`:

```bash
dart pub global activate mason_cli
```

### 2. Add the Brick

Add `kuwe_flutter_starter` globally or to your project's `mason.yaml`:

```bash
# Add from BrickHub
mason add kuwe_flutter_starter

# Or add globally
mason add -g kuwe_flutter_starter
```

### 3. Generate a Project

Run `mason make` to generate your new Flutter application:

```bash
mason make kuwe_flutter_starter
```

You will be prompted for:
- **`project_name`**: The name of the project in snake_case (default: `my_app`).
- **`description`**: A short project description (default: `A Flutter App`).
- **`org_name`**: The organization identifier (default: `com.example`).

Alternatively, pass variables directly via CLI:

```bash
mason make kuwe_flutter_starter \
  --project_name awesome_app \
  --description "My Awesome Flutter App" \
  --org_name com.company.app \
  -o awesome_app
```

---

## Variables 📋

| Variable | Description | Default |
|---|---|---|
| `project_name` | The name of your Flutter app | `my_app` |
| `description` | Short description of your project | `A Flutter App` |
| `org_name` | Organization identifier (e.g. `com.example`) | `com.example` |

---

## Post-Generation Setup ⚙️

After generating your project:

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate code (AutoRoute, Envied, etc.):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Configure Firebase:**
   Update `lib/firebase_options.dart` with your project's credentials using the FlutterFire CLI:
   ```bash
   flutterfire configure
   ```

4. **Run the application:**
   ```bash
   # Development flavor
   flutter run -t lib/main_development.dart

   # Production flavor
   flutter run -t lib/main_production.dart
   ```

---

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
