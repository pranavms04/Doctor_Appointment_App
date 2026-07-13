# 🩺 Doctor Appointment App

A highly optimized, performance-driven Flutter application tailored for medical practitioners. This project delivers real-time appointment tracking, patient medical histories, clinical session note management, and a network-resilient WebRTC video consultation pipeline built with a unified modern design system token engine.

---

## 🚀 How to Run the App

### Prerequisites
* **Flutter SDK:** `>=3.3.0`
* **Dart SDK:** `>=3.3.0`
* **Cocoapods** (For iOS compilation targets)

### Native Permissions Configuration
Before running the application, ensure your native configuration files are updated for WebRTC camera and microphone hardware stream access:

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
