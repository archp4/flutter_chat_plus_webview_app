# 💬 Flutter Chat App with WebView Integration

This is a Flutter application demonstrating a clean architecture (MVVM/Provider) for a chat interface, featuring message persistence via Shared Preferences and integration with a local web application via WebView.

## 🚀 Setup & Run Guide

### Prerequisites

1.  **Flutter SDK:** Installed and configured.
2.  **Angular Web App:** The target Angular application source code.
3.  **Same Network:** Your development machine and mobile device/emulator must be connected to the same local network.

### Step 1: Start the Web Server (Angular)

Navigate to the root of your Angular project and run the server, ensuring it listens on your network IP:

```bash
ng serve --host 0.0.0.0 --port 4200
```

Crucial: Note your machine's network IP (e.g., 192.168.1.5).

### Step 2: Configure Flutter Network Access

Open `lib/providers/home_view_model.dart`.

UPDATE the `_localIpAddress` constant with the IP you found in Step 1.

```dart
const String _localIpAddress = 'YOUR_ACTUAL_IP_ADDRESS';
```

### Step 3: Run the Flutter App

```bash
flutter run
```

#### App Features

Chat Room: Send messages and receive automated replies.

Persistence: Toggle message saving/loading using the switch on the Dashboard.

WebView: Access the running Angular website by switching to the "Dashboard (Web View)" view.

#### Architecture Highlights

State Management: provider (ChangeNotifier/Consumer).

Data Layer: Message persistence handled by MessageStorageService (using shared_preferences).

Data Models: MessageBubble implements JSON serialization/deserialization and Comparable for time-based sorting.
