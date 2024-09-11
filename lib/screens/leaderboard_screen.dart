import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/quiz.dart';
import 'package:quizapp/service/auth_service.dart';
import 'login_screen.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen(this.leaderboard, {super.key});

  final List<Map<String, dynamic>> leaderboard;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Sort leaderboard based on score in descending order
    final sortedLeaderboard = List<Map<String, dynamic>>.from(leaderboard)
      ..sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.deepPurple,
        actions: [
          // Home Button
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Quiz()),
              );
            },
          ),
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: sortedLeaderboard.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: sortedLeaderboard.length,
        itemBuilder: (context, index) {
          final entry = sortedLeaderboard[index];
          return ListTile(
            leading: Text('#${index + 1}'),
            title: Text('User: ${entry['name']}'),
            trailing: Text('Score: ${entry['score']}'),
          );
        },
      ),
    );
  }
}
