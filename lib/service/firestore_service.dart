import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveScore(String userId, int score) async {
    await _db.collection('users').doc(userId).set({'score': score});
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    final querySnapshot = await _db.collection('users').orderBy('score', descending: true).limit(10).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
