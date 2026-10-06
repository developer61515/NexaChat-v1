#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
command -v node >/dev/null || { echo 'Node.js is required'; exit 1; }
command -v java >/dev/null || { echo 'Java/JDK is required'; exit 1; }
if [[ -z "${ANDROID_HOME:-}" && -z "${ANDROID_SDK_ROOT:-}" ]]; then
  echo 'ANDROID_HOME/ANDROID_SDK_ROOT is not set. Use GitHub Actions with build-apk.yml or install Android SDK.'
  exit 2
fi
npm install --no-audit --no-fund
npm install --save-exact --no-audit --no-fund @capacitor/core@7.0.0 @capacitor/cli@7.0.0 @capacitor/android@7.0.0
cp capacitor/capacitor.config.json ./capacitor.config.json
rm -rf android
npx cap add android
npx cap sync android
(cd android && ./gradlew assembleDebug --no-daemon --stacktrace)
cp android/app/build/outputs/apk/debug/app-debug.apk ./NexaChat-debug.apk
echo "APK: $ROOT/NexaChat-debug.apk"
