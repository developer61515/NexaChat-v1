# NexaChat — Build APK

## Automatic build (recommended)

The repository includes `.github/workflows/build-apk.yml`.

GitHub's hosted Android runner supplies the Android SDK/toolchain. The workflow:
1. installs Node/Capacitor;
2. creates the Android wrapper from `web/`;
3. runs `npx cap sync android`;
4. runs Gradle `assembleDebug`;
5. publishes `NexaChat-debug.apk` as an Actions artifact.

Capacitor officially supports building Android APKs through `npx cap build android`; the same native Android toolchain is used here in CI.

## Local build

On a machine with Android SDK configured:

```bash
./scripts/build-apk.sh
```

The output is:

```text
NexaChat-debug.apk
```

This is a debug APK for direct testing/install, not a Play Store release APK.
