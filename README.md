# nava Real-Time Emotion Map

## Overview
Nava-App is a real-time emotion map application designed to visualize and share emotional data and music preferences on a color-coded interactive map of Istanbul. The app allows users to post their emotional states, choose music, and view weekly statistics.

## Features

### Authentication
- Users can register and log in using Firebase Authentication.
- Secure user account management, including password reset functionality.

### Screens
1. **Homepage**:
   - Displays a non-interactable SVG map of Istanbul.
   - Users can create posts by selecting emotions, provinces, and music tracks provided by Spotify.
   - Posts are stored in Firestore DB.

2. **Profile**:
   - Shows the user's posts with options to delete them.

3. **Stats**:
   - Weekly emotion pie charts for the user.
   - District-based weekly emotion distribution pie charts.

### Post Creation
- Users can create posts by:
  - Selecting one of 7 emotions (e.g., happy, sad, angry).
  - Choosing a district in Istanbul.
  - Adding a Spotify track with album art.
- Posts are saved to Firestore and displayed on the Profile screen.

### Real-Time Map
- Future development: Interactive SVG map to display posts by clicking on districts.

## Technical Details
- **Frontend**: Built with Flutter.
- **Backend**: Firebase Firestore for database and Firebase Auth for user authentication.
- **Database**: Firestore Database for storing posts and user data.
- **Third-Party Services**:
  - Spotify API integration for music selection and album art.

## Project Structure
```
lib/
├── main.dart          # Application entry point
├── screens/           # Contains Homepage, Profile, and Stats screens
├── services/          # Firebase Authentication and Firestore services
├── widgets/           # Reusable components like CreatePost widget
├── assets/            # Contains SVG map and other static assets
```

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/ilaydayilmazx/nava-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd nava-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Usage
1. Register or log in using your email and password.
2. Navigate to the Homepage to create a post.
3. View your posts on the Profile screen.
4. Check weekly emotion stats on the Stats screen.

## Future Improvements
- Make the Istanbul SVG map interactive.
- Allow users to filter posts by districts or emotions.
- Add real-time data synchronization for multi-user support.
- Implement push notifications for weekly stats updates.

## Contributors
- **Ilayda Yilmaz** (GitHub: [ilaydayilmazx](https://github.com/ilaydayilmazx))
- **Ceyda** (Branch collaborator)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to contribute by submitting issues or pull requests!

