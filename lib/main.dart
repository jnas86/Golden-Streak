import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class _QuestionsPage extends State<QuestionsPage>{

  int question_counter = 1;
  String question_text = 'String Question body String Question body String Question body';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'Q : $question_counter',
              style: const TextStyle(
                fontFamily: 'Caveat',
                fontWeight: FontWeight.bold,
                fontSize: 50.0
              ),
            ),
          ),
        ),
        Text(
            '$question_text?',
          style: const TextStyle(
            fontFamily: 'Caveat',
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0,150,0,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('images/dislike.png'),
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('images/like.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

