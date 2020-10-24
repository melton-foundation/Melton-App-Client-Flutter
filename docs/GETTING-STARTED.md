# Install Flutter
See [https://flutter.dev/](https://flutter.dev/)

# Find a server
Either clone and run [Melton App Server](https://github.com/melton-foundation/Melton-App-Server/) on your local env (and replace the localhost URL in `api.dart`) or get a token from [Pranav Bijapur](mailto:bijapurpranav@gmail.com) to access the prod server APIs

# Create API keys
Replace the "YOUR_KEY_HERE" in the app with your API keys for the features you want to check out:
- Google Oauth - used for sign in flow, create it from Google Cloud or Firebase.
    -  For iOS, replace your iOS client ID in reverse domain notation in `Info.plist` and add your `GoogleService-Info.plist` to `ios/Runner`
            ```
            <key>CFBundleURLSchemes</key>
            <array>
                <string>YOUR_KEY_HERE</string>
            </array>
            ```
    -  For Android, place `google-services.json` in your `android/app` folder.

    NOTE: you can bypass this by saving a token (from the backend) in your local storage, either get this from your local Melton App Server setup or ask Pranav.

- Google Maps - Used in Fellows Map feature, create API key from Google Cloud console
    -  For iOS, replace in `AppDelegate.swift`
            `GMSServices.provideAPIKey("YOUR-API-KEY")`
    -  For Android, replace in your `AndroidManifest.xml`
            ```xml
            <meta-data android:name="com.google.android.geo.API_KEY"
                        android:value="YOUR-KEY-HERE"/>
            ```

- Sentry DSN - used for error reporting to https://sentry.io
    -  replace your Sentry DSN in `secrets.dart`
            `static const SENTRY_CLIENT_DSN = "ADD_SENTRY_DSN_KEY_HERE";`

# Eat some ice-cream, you're all set :)

