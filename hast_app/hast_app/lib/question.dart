import 'package:flutter/material.dart';

int question_number = 1;
String question_title = 'Lifestyle and Work Assessment';
String question_text = 'Reactivity vs. finding \'the space\'';

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(question_title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _QuestionText(question_text),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AnswerText('answer1www'),
                _AnswerText('answer2'),
                _AnswerText('answer3'),
                _AnswerText('answer4')
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AnswerText extends StatelessWidget {
  final String atext;

  _AnswerText(this.atext);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        color: Colors.green,
        child: Text(
          atext,
          style: TextStyle(
            fontSize: 14,
          ),
        )
      )
    );
  }
}

class _QuestionText extends StatelessWidget {
  final String qtext;

  _QuestionText(this.qtext);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Text(
        qtext,
        //textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}