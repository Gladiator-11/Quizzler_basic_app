import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuestionBrain.dart';

QuestionBrain quizBrain = QuestionBrain();
void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Quiz App',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  @override
  _QuizpageState createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List<Icon> scorekeeper = [];

  void checkanswer(bool userpickanswer) {
    bool correctanswers = quizBrain.QuestionAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: "Finished",
          desc: "This Quiz is over press the button to give th equiz again.",
        ).show();

        quizBrain.reset();

        scorekeeper = [];
      } else {
        if (userpickanswer == correctanswers) {
          scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scorekeeper.add(
            Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          );
        }

        quizBrain.NextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.QuestionText(),
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
                checkanswer(true);
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
                checkanswer(false);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: scorekeeper,
          ),
        )
      ],
    );
  }
}
