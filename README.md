# Lucky Chat

Mobile-first neobrutalist chat application starter, designed for Android/PWA.

## Included
- Standalone dependency-free web app
- PWA manifest + service worker
- Local persistence (localStorage)
- Chats, groups, channels, contacts, profile, settings
- Search/filter
- Compose message, reply/edit/delete/forward/react/pin
- Attach image/file, voice-note recording when browser supports MediaRecorder
- Theme toggle and notification permission helper
- Capacitor Android project configuration
- Optional Node/Express + Socket.IO backend starter

## Run web
Open `web/index.html` in a modern browser, or serve the `web` directory with any static server.

## Build Android
This repository contains the Android packaging configuration, but an APK requires the Android SDK/Gradle toolchain. Typical commands on a machine with Node + Android SDK:

```bash
npm install
npx cap add android
npx cap sync android
npx cap open android
```

Then build the APK with Android Studio/Gradle.

## Backend
See `server/README.md`. The frontend currently works locally without a backend; realtime multi-device chat requires running the server and a database/auth layer.

## Build APK with GitHub Actions

The repository contains `.github/workflows/build-apk.yml`. Upload the project to GitHub, open **Actions**, select **Build Lucky Chat APK**, and press **Run workflow**. When it finishes, download the `LuckyChat-debug-apk` artifact.

The workflow builds the Android wrapper from the `web/` app using Capacitor and Gradle. The generated debug APK is for testing and direct installation; it is not a Play Store release build.
