# groz2

A cross-platform grocery management app built with Flutter, supporting Android, iOS, Web, Windows, Linux, and macOS.  
Features include team-based grocery lists, voice input, recommendations, and Firebase integration for authentication and real-time data.

---

## Features

- **Team-based grocery lists:** Organize and share lists with teams.
- **Voice input:** Add items using voice commands (mic integration).
- **Recommendations:** Get item suggestions based on previous activity.
- **Firebase integration:**  
  - Authentication (`firebase_auth`)
  - Cloud Firestore for real-time data (`cloud_firestore`)
  - Offline persistence
- **Cross-platform:** Runs on Android, iOS, Web, Windows, Linux, and macOS.
- **Modern UI:** Gradient backgrounds, Material Design, and custom navigation bar.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Platform-specific requirements (Android Studio, Xcode, etc.)

### Installation

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd groz2
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Firebase setup:**
   - Ensure `google-services.json` (Android) and `firebase_options.dart` are present.
   - Update Firebase project settings if needed.

4. **Run the app:**
   - For Android/iOS:
     ```sh
     flutter run
     ```
   - For Web:
     ```sh
     flutter run -d chrome
     ```
   - For Windows/Linux/macOS:
     ```sh
     flutter run -d windows
     ```

---

## Project Structure

- `lib/`
  - `main.dart` – App entry point, authentication check, navigation
  - `pages/` – Main UI pages: `home_page.dart`, `listing_page.dart`, `notify_page.dart`, `account_page.dart`
  - `service/` – Business logic: mic service, team handling, suggestions
  - `widgets/` – Custom widgets (e.g., navigation bar, greetings)
- `assets/` – App images and icons
- `android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/` – Platform-specific code and configs

---

## Key Packages

- [`firebase_core`](https://pub.dev/packages/firebase_core)
- [`firebase_auth`](https://pub.dev/packages/firebase_auth)
- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore)
- [`device_info_plus`](https://pub.dev/packages/device_info_plus)
- [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- [`crypto`](https://pub.dev/packages/crypto)

---

## Configuration

- **Firebase:**  
  - Android: `android/app/google-services.json`
  - Dart: `lib/firebase_options.dart`
- **Assets:**  
  - Defined in [`pubspec.yaml`](pubspec.yaml) under `assets:`
- **Build:**  
  - Use `flutter build <platform>` for release builds.

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## License

This project is licensed under the MIT License.

---

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase for Flutter](https://firebase.flutter.dev/)
