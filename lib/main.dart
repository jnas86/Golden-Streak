import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grand_serie/question.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<List<Question>> get_questions_from_api() async {
  final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=50&type=boolean'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['results'];
    return data.map((json) => Question.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load questions');
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: <Color>[Colors.green, Colors.cyan])),
          ),
          centerTitle: true,
          title: const Text(
            'Grand Streak',
            style: TextStyle(
              fontFamily: 'Caveat',
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Colors.black87,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.amberAccent,Colors.redAccent]
              )
          ),
          child: const QuestionsPage(),
        ),
      )
    );
  }
}

class QuestionsPage extends StatefulWidget{
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPage();
}

class _QuestionsPage extends State<QuestionsPage> {
  late Future<List<Question>> future_questions;
  int answer_streak = 0;
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    future_questions = get_questions_from_api();
  }


  String question_body = 'String Question body String Question body String Question body';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: future_questions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          questions = snapshot.data!;
          return Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Streak : $answer_streak',
                    style: const TextStyle(
                        fontFamily: 'Caveat',
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0),
                  ),
                ),
              ),
              Text(
                questions[answer_streak].question,
                style: const TextStyle(
                  fontFamily: 'Caveat',
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('images/dislike.png'),
                      ),
                      onTap: () => checkAnswer(false),
                    ),
                    GestureDetector(
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('images/like.png'),
                      ),
                      onTap: () => checkAnswer(true),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  void checkAnswer(bool userChoice) {
    if (userChoice == (questions[answer_streak].correct_answer == "True")) {
      // User's choice is correct
      if (answer_streak < questions.length - 1) {
        // Display next question
        setState(() {
          answer_streak++;
          // Update question_body with the text of the next question
        });
      } else {
        // User has answered all questions correctly
        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: const Text("Congratulations"),
                content: const Text("You won 50 question in a row!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Reset the quiz
                      setState(() {
                        answer_streak = 0;
                        // Update question_body with the text of the first question
                      });
                    },
                    child: const Text("Restart"),
                  ),
                ],
              ),
        );
      }
    } else {
      // User's choice is incorrect
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: const Text("You Lost"),
              content: const Text("Better luck next time!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reset the quiz
                    setState(() {
                      answer_streak = 0;
                      // Update question_body with the text of the first question
                    });
                  },
                  child: const Text("Restart"),
                ),
              ],
            ),
      );
    }
  }
}
