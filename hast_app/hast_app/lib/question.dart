import 'package:flutter/material.dart';
import 'dart:io' show Platform;

int question_number = 1;
String question_title = 'Lifestyle and Work Assessment';
String question_text = 'Reactivity vs. finding \'the space\'';
String option1 = 'You often overreact to other people, since you are often '
    'treated unfairly. Sometimes you feel the world is against you.';
String option2 = 'You see that you react in ways that don’t work in many '
    'situations. You don’t feel good about it, but you have no idea how to '
    'change your behaviour.';
String option3 = 'You often catch yourself when you overreact, you find ‘the '
    'space’, and from there you can create a more balanced response.';
String option4 = 'As you let your reactions be instead of trying to change them,'
    '  you often get insights and see new possibilities.';
String subOption1 = 'some of the time'; //Vad betyder egentligen graderingen som görs i fas två
String subOption2 = 'almost all of the time';
String subOption3 = 'always';
String subOption4 = '10 11 12';

class _CreateAnswers extends StatelessWidget {

  final String a1;
  final String a2;
  final String a3;
  final String a4;

  _CreateAnswers(this.a1, this.a2, this.a3, this.a4);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _AnswerText(a1)),
          Expanded(child: _AnswerText(a2)),
          Expanded(child: _AnswerText(a3)),
          Expanded(child: _AnswerText(a4)),
        ],
        )
      );
  }
}
class _CreateFollowUpAnswers extends StatelessWidget {

  final String a1;
  final String a2;
  final String a3;
  final String a4;

  _CreateFollowUpAnswers(this.a1, this.a2, this.a3, this.a4);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _FollowUpAnswerText(a1)),
            Expanded(child: _FollowUpAnswerText(a2)),
            Expanded(child: _FollowUpAnswerText(a3)),
            //Expanded(child: _FollowUpAnswerText(a4)),
          ],
        )
    );
  }
}

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(question_title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: <Widget>[
              _QuestionText(question_text),
              _CreateAnswers(option1, option2, option3, option4),
              _CreateFollowUpAnswers(subOption1,subOption2,subOption3,subOption4)
            ],
          ),
        ),
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          qtext,
          style: TextStyle(
            fontSize: 24,
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Text(
            atext,
            style: TextStyle(
              fontSize: 14,
            ),
          )
        )
      )
    );
  }
}

class _FollowUpAnswerText extends StatelessWidget {
  final String atext;

  _FollowUpAnswerText(this.atext);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(

            color: Colors.yellow,
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  atext,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
            )
        )
    );
  }
}
