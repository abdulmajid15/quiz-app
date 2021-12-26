import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizbrain = QuizBrain();
void main() {
  runApp(Quizler());
}

class Quizler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var score = 0;
  List<Icon> scoreKeeper = [
    // Icon(
    //   Icons.check,
    //   color: Colors.green,
    // ),
    // Icon(
    //   Icons.check,
    //   color: Colors.red,
    // ),
    // Icon(
    //   Icons.check,
    //   color: Colors.green,
    // ),
    // Icon(
    //   Icons.check,
    //   color: Colors.green,
    // ),
    // Icon(
    //   Icons.check,
    //   color: Colors.green,
    // ),
  ];

  void trackAnswer(bool userPickAnswer) {
    bool checkAnswer = quizbrain.getAnswer();
    setState(() {
      if (quizbrain.isFinished() == true) {
        Alert(
          // alertAnimation: ,
          context: context,

          title: 'Finished!',
          desc: 'Correct Answers: ${score} \nQuiz Ended.',
        ).show();

        quizbrain.reset();

        // scoreKeeper = [];
      } else {
        if (userPickAnswer == checkAnswer) {
          score++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        quizbrain.nextQuestion();
      }
    });
  }

  // List<String> questions = [//   'There are five fingers in human hand?',//   'majid is Teacher?',// 'Pakistanis city?'
  // ];// List<bool> answers = [true, false, false];

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizbrain.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  trackAnswer(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  trackAnswer(false);
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: scoreKeeper,
            ),
          )
        ],
      );
}
