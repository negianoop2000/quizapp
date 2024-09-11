# Quiz App

This is a quiz platform built using Flutter. The platform allows users to log in using Google, answer questions, track scores, and view a summary of their results.

## External Packages Used

The following external packages are used in this project:

1. **`firebase_auth`**: Provides authentication features for Firebase, including Google sign-in.
    - Version: `firebase_auth: ^5.2.0`

2. **`google_sign_in`**: Used to authenticate users with their Google account.
    - Version: `google_sign_in: ^6.2.1`

3. **`firebase_core`**: Required for initializing Firebase in Flutter.
    - Version: `firebase_core: ^3.4.0`

4. **`firebase_database`**: Used for integrating with Firebase Realtime Database to store questions and scores.
    - Version: `firebase_database: ^11.1.1`

5. **`provider`**: Used for state management across the app.
    - Version: `provider: ^6.1.2`

6. **`google_fonts`**: Allows the usage of Google Fonts in the app.
    - Version: `google_fonts: ^6.2.1`

7. **`cloud_firestore`**: Used for showing the name of user using gmail-login.
    - Version: `flutter_local_notifications: ^5.4.0`

8. **`shared_preferences`**: Used to store user-related data locally.
    - Version: `shared_preferences: ^2.3.2`

## Features

- Google Sign-In for user authentication
- Display of questions fetched from Firebase Realtime Database
- Tracking and displaying user scores
- Leaderboard functionality with Firebase Realtime Database
- User-friendly UI with Google Fonts


