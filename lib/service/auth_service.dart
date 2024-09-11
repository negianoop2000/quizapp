import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseReference _questionsRef = FirebaseDatabase.instance.ref('questions');
  final DatabaseReference _scoresRef = FirebaseDatabase.instance.ref('scores'); // For user scores

  // Stream to listen to auth changes
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Save user score to the 'scores' path
  Future<void> saveUserScore(int score) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _scoresRef.child(user.uid).set({
        'score': score,
        'name': user.displayName ?? 'Anonymous',  // Save the user's name
      });
    }
  }

  // Get user score from the 'scores' path
  Future<int> getUserScore() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _scoresRef.child(user.uid).once();
      final data = snapshot.snapshot.value as Map<dynamic, dynamic>;
      return data['score'] ?? 0;
    }
    return 0;
  }

  // Get questions from Realtime Database
  Future<List<Map<String, dynamic>>> getQuestions() async {
    final snapshot = await _questionsRef.get(); // Fetch the 'questions' node

    if (snapshot.exists) {
      final Map<dynamic, dynamic> questionsData = snapshot.value as Map<dynamic, dynamic>;

      List<Map<String, dynamic>> questionsList = [];
      questionsData.forEach((key, value) {
        Map<String, dynamic> questionMap = Map<String, dynamic>.from(value as Map<dynamic, dynamic>);
        questionsList.add(questionMap);
      });

      return questionsList;
    }
    return [];
  }

  // Save leaderboard entry with user's name
  Future<void> saveLeaderboardEntry(String userId, int score, String userName) async {
    await FirebaseDatabase.instance.ref('leaderboard').push().set({
      'userId': userId,
      'score': score,
      'name': userName,  // Save the user's name
    });
  }

  // Get leaderboard from Realtime Database
  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    final snapshot = await FirebaseDatabase.instance.ref('leaderboard').get();
    if (snapshot.exists) {
      final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      return data.entries.map((entry) {
        final Map<String, dynamic> leaderboardEntry = Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>);
        return leaderboardEntry;
      }).toList();
    }
    return [];
  }
}
