import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/service/auth_service.dart';

import '../components/questions_summary.dart';
import 'leaderboard_screen.dart';

class ResultsScreen extends StatelessWidget {
const ResultsScreen({
required this.chosenAnswers,
required this.score,
required this.previousScore,
required this.onRestart,
required this.summaryData,
super.key,
});

final List<String> chosenAnswers;
final int score;
final int previousScore;
final VoidCallback onRestart;
final List<Map<String, Object>> summaryData;

@override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade500,
      appBar: AppBar(
        title: const Text('Results Screen', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white),
            ),
           const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.restart_alt),
              onPressed: onRestart,
              label: const Text('Restart Quiz!'),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QuestionsSummary(summaryData),
                  )),
            ),
            SizedBox(height: 30,),

            ElevatedButton(
              onPressed: () async {
                final leaderboard = await authService.getLeaderboard();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaderboardScreen(leaderboard),
                  ),
                );
              },
              child: Text('View Leaderboard',style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}


