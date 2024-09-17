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

7. **`cloud_firestore`**: Used for storing and displaying the user's name using Google login.
    - Version: `cloud_firestore: ^5.4.0`

8. **`shared_preferences`**: Used to store user-related data locally.
    - Version: `shared_preferences: ^2.3.2`

## Features

- **Google Sign-In** for user authentication
- **Firebase Realtime Database** to fetch and display quiz questions
- **Tracking and Displaying Scores**: Tracks user performance in real time
- **Leaderboard Functionality**: Displays top scores using Firebase Realtime Database
- **Question Summary**: Shows the summary of questions and answers after quiz completion
- **User-friendly UI**: Customized using Google Fonts

## Screen Recording

You can view a complete walk-through of the platform in the following screen recording:

[Screen Recording - Quiz App](https://drive.google.com/file/d/1ugsghRDtCtyxMliDAszOVS3czgFvt1oV/view?usp=sharing)

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/467d104f-fab6-44d2-846a-274c9fdf8497" alt="Image 1" width="200" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/a2d4aab6-a5c2-42ad-b5d2-12a18804456c" alt="Image 2" width="200" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/3c54a537-0d43-4bec-a6c5-971a391b8fec" alt="Image 3" width="200" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/c6067486-7e5d-45c3-9acb-15407b2ba206" alt="Image 4" width="200" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/668462ac-7c73-42cb-996a-9c7ba34989ba" alt="Image 5" width="200" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/68762111-e1cd-4760-8a5e-6311d4aea9eb" alt="Image 6" width="200">
</p>



## Getting Started

Follow the instructions below to set up the project locally.

### Prerequisites

Make sure you have Flutter and Dart installed on your machine. You will also need a Firebase account to configure the app.

1. **Clone the repository**:
   
   git clone https://github.com/yourusername/your-repository-name.git
   
2. **Navigate to the project directory**:

cd your-repository-name

3. **Install dependencies**:

flutter pub get

4. **Set up Firebase**:

Create a project on Firebase and configure it for your app.
Download the google-services.json file from Firebase and place it in the android/app directory.
Enable Google Sign-In in Firebase Authentication.

5. **Configure Firebase Database**:

In Firebase Console, go to Realtime Database and set up the rules to allow public read/write for development purposes (ensure to secure this in production).
Add questions and leaderboard data to the database.

6. **Run the app**:

flutter run
