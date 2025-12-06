# Full-Stack Run Guide (Flutter + Angular on Localhost)

This document explains how to run an Angular application locally and connect it to a Flutter app using WebView. All steps are written in third person for documentation purposes.

---

## I. Angular HTTP Server Setup & Startup

To ensure the Angular app is accessible across the local network (not just `127.0.0.1`), the following steps must be performed.

### 1. Navigate to the Angular Project

Open a terminal and move into the root directory of the Angular project.

### 2. Start the Angular Development Server

Run the server with network-wide access enabled:

```bash
ng serve --host 0.0.0.0 --port 4200
```

**Explanation:**

- `--host 0.0.0.0` → Allows access from all devices on the local network (e.g., phone, emulator).
- `--port 4200` → Uses Angular’s default development port.

### 3. Find the Computer’s Local IP Address

This IP address will be used inside the Flutter WebView.

- **Windows:** `ipconfig` (look for `IPv4 Address`)
- **macOS/Linux:** `ifconfig` or `ip addr`

Example IP: `192.168.1.5`

---

## II. Flutter App Configuration & Run

This section ensures the Flutter app points to the Angular server correctly.

### 1. Verify IP Address in the ViewModel

Open:
`lib/providers/home_view_model.dart`

Update the IP address:

```dart
// ⚠️ IMPORTANT: Replace this with the actual machine IP address
const String _localIpAddress = 'YOUR_ACTUAL_IP_ADDRESS'; // e.g., '192.168.1.5';
const String _localUrl = 'http://$_localIpAddress:4200';
```

### 2. Run the Flutter App

Ensure a physical device or emulator is connected, then run:

```bash
flutter run
```

---

## Networking Notes

### Physical Device

- Must be connected to the **same Wi-Fi network** as the development machine.

### Android Emulator

- It may require the special host alias:
  `10.0.2.2:4200`
- If the actual IP (`192.168.x.x`) fails, temporarily try using `10.0.2.2` in the ViewModel.

### iOS Simulator

- Connects directly to the host network; the actual IP should work normally.

---

## III. Assumptions & Stretch Goals

The provided implementation incorporates modern Flutter architecture practices and enhanced features:

| Feature                | Assumption / Goal                           | Status    |
| ---------------------- | ------------------------------------------- | --------- |
| Separation of Concerns | Implement MVVM + Provider pattern           | Completed |
| Persistence Logic      | Store data using SharedPreferences          | Completed |
| Clean Architecture     | Use a dedicated `MessageStorageService`     | Completed |
| Data Integrity         | Load & save messages in chronological order | Completed |
| Dynamic Configuration  | Add `_isPersistenceEnabled` toggle          | Completed |
| UI Enhancements        | Manage state cleanly                        | Completed |
