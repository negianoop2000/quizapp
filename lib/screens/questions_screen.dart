import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/service/auth_service.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({required this.onSelectAnswer, super.key});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late Future<List<Map<String, dynamic>>> questionsFuture;
  Map<String, dynamic>? currentQuestion;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    questionsFuture = _loadQuestions();
  }

  Future<List<Map<String, dynamic>>> _loadQuestions() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    return await authService.getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: questionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading questions'));
        } else if (snapshot.hasData) {
          final questions = snapshot.data!;
          if (currentIndex < questions.length) {
            currentQuestion = questions[currentIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentQuestion!['text'],
                    style: TextStyle(fontSize: 24),
                  ),
                  ...List.generate(
                    (currentQuestion!['answers'] as List).length,
                        (index) => ElevatedButton(
                      onPressed: () {
                        widget.onSelectAnswer(
                            (currentQuestion!['answers'] as List)[index]);
                        setState(() {
                          currentIndex++;
                        });
                      },
                      child: Text((currentQuestion!['answers'] as List)[index]),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No more questions'));
          }
        } else {
          return Center(child: Text('No questions found'));
        }
      },
    );
  }
}
