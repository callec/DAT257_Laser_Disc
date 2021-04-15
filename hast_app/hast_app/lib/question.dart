import 'package:flutter/material.dart';

/// A function used in many places that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n);

class Question extends StatelessWidget {

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

  String subOption1 = '1'; //Vad betyder egentligen graderingen som görs i fas två
  String subOption2 = '2';
  String subOption3 = '3';


  /// Takes an int and returns a Color (has an optional intensity argument).
  Color _getColor(int n, [int intensity = 200]) {
    switch (n) {
      case 0:
        return Colors.red[intensity];
      case 1:
        return Colors.yellow[intensity];
      case 2:
        return Colors.green[intensity];
      case 3:
        return Colors.blue[intensity];
      default:
        return Colors.grey[intensity];
    }
  }

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
              _CreateAnswers(option1, option2, option3, option4, _getColor),
              _CreateFollowUpAnswers(0)
            ],
          ),
        ),
      )
    );
  }
}

/// Create a row of _AnswerText objects that are displayed on the screen.
///
/// Has arguments 4 strings and a function.
class _CreateAnswers extends StatelessWidget {

  final String a1;
  final String a2;
  final String a3;
  final String a4;

  final _ColorCallBack colorFunction;

  _CreateAnswers(this.a1, this.a2, this.a3, this.a4, this.colorFunction);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _AnswerText(a1, 0, colorFunction)),
            Expanded(child: _AnswerText(a2, 1, colorFunction)),
            Expanded(child: _AnswerText(a3, 2, colorFunction)),
            Expanded(child: _AnswerText(a4, 3, colorFunction)),
          ],
        )
    );
  }
}

/// Create the three alternatives used to answer questions.
///
/// Has arguments three strings which shows that to display
class _CreateFollowUpAnswers extends StatelessWidget {

  final int a1;

  _CreateFollowUpAnswers(this.a1);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _FollowUpAnswerText(a1)),
            Expanded(child: _FollowUpAnswerText(a1+1)),
            Expanded(child: _FollowUpAnswerText(a1+2)),
          ],
        )
    );
  }
}

/// Displays the question on the screen
///
/// Takes a string of the question text as the argument
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

/// Creates a single answertext object
///
/// Arguments: answer text, a number, a function
class _AnswerText extends StatelessWidget {
  final String atext;
  final _ColorCallBack colorFunction;
  final int number;

  _AnswerText(this.atext, this.number, this.colorFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Material(
        child: InkWell(
          onTap: () {print("Hello, world!");},
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                atext,
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            )
          ),
        ),
        color: colorFunction(number),
      ),
    );
  }
}

/// Creates a single FollowupAnswerText object
///
/// Argument: a string
class _FollowUpAnswerText extends StatelessWidget {

  final int number;

  _FollowUpAnswerText(this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Material(
        child: ElevatedButton( style: ElevatedButton.styleFrom(
          primary:Colors.red,
            onPrimary: Colors.white,
         ),

          onPressed: () {print("Hello, world!");},
          child: Container(
              color: Colors.transparent,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
              )
          ),
        ),
        color: Colors.green,
      ),
    );
  }
}
