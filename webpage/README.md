# Webpage - Angular Component

This is the Angular application intended to be loaded within the Flutter application's WebView.

## How to Start the Development Server

To ensure this application is accessible to the Flutter app running on a mobile device or emulator, you must start the server on all network interfaces.

1.  **Navigate** to this directory in your terminal.
2.  **Run the following command:**

    ```bash
    ng serve --host 0.0.0.0 --port 4200
    ```

### Server Configuration Details

- **`--host 0.0.0.0`**: Required to allow the Flutter app (running on a separate device/emulator) to connect over the local network.
- **Port:** Runs on the default Angular port, `4200`.

### Troubleshooting Connection Issues

If the Flutter app's WebView shows a connection error:

1.  **Verify IP Address:** Check that the IP address configured in the Flutter `HomeViewModel` is the same as your machine's local IP address.
2.  **Check Firewall:** Ensure your computer's firewall is not blocking incoming connections on port `4200`.
3.  **Emulator Use:** If running on an Android Emulator, try using the host alias `10.0.2.2` in the Flutter code.

```

```
