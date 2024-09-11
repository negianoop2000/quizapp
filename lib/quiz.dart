import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/screens/login_screen.dart';
import 'package:quizapp/service/auth_service.dart';
import 'package:quizapp/screens/questions_screen.dart';
import 'package:quizapp/screens/results_screen.dart';
import 'package:quizapp/screens/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  List<Map<String, dynamic>> questions = [];
  var activeScreen = 'start-screen';
  int score = 0;
  int previousScore = 0;
  String userName = 'Anonymous';  // Default name
  String userId = '';  // Default user ID
  List<Map<String, Object>> summaryData = [];
  @override
  void initState() {
    super.initState();
    _fetchPreviousScore();
    _fetchQuestions();
    _fetchUserDetails();
  }

  Future<void> _fetchPreviousScore() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    previousScore = await authService.getUserScore();
    setState(() {});
  }

  Future<void> _fetchQuestions() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    questions = await authService.getQuestions();
    setState(() {});
  }

  Future<void> _fetchUserDetails() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = await authService.user.first; // Await the stream to get the current user
    if (user != null) {
      userName = user.displayName ?? 'Anonymous';  // Get user name or use default
      userId = user.uid;  // Get user ID
      setState(() {});
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      // Calculate the score
      score = 0;

      for (int i = 0; i < questions.length; i++) {
        final question = questions[i];
        final correctAnswer = question['correct_answer'];
        final userAnswer = selectedAnswers[i];
        if (userAnswer == correctAnswer) {
          score++;
        }
        summaryData.add({
          'questions_index': i,
          'question': question['text'],
          'user_answer': userAnswer,
          'correct_answer': correctAnswer,
        });
      }

      setState(() {
        activeScreen = 'results-screen';
      });
      _saveScore();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            chosenAnswers: selectedAnswers,
            score: score,
            previousScore: previousScore,
            onRestart: restartQuiz,
            summaryData: summaryData, // Pass summary data here
          ),
        ),
      );
    }
  }

  Future<void> _saveScore() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (userId.isNotEmpty) {
      await authService.saveUserScore(score);
      await authService.saveLeaderboardEntry(userId, score, userName);  // Pass userId and userName
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen, previousScore);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        score: score,
        previousScore: previousScore,
        onRestart: restartQuiz, summaryData: summaryData,
      );
    }

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 122, 70, 212),
              Color.fromARGB(255, 71, 38, 128),
            ],
          ),
        ),
        child: screenWidget,
      ),
    );
  }
}
