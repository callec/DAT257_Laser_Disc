import 'package:flutter/material.dart';

/// A function used in many places that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

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

  bool _displayFollowUp = false;
  int _followUpNumber = -1;
  Color _followUpColor = Colors.transparent;

  void callBack(int n) {
    print("$_followUpNumber");
    if (_followUpNumber == n) {
      setState(() {
        _displayFollowUp = false;
        _followUpNumber = -1;
        _followUpColor = Colors.transparent;
      });
    } else {
      _displayFollowUp = false;
      _followUpNumber = n;
      _followUpColor = _getColor(n);
      setState(() => _displayFollowUp = true);
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
                _CreateAnswers(option1, option2, option3, option4, _getColor, callBack),
                _displayFollowUp ?
                _CreateFollowUpAnswers(_followUpNumber, _followUpColor)
                    :
                Text(""),
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
class _CreateAnswers extends StatefulWidget {

  final String a1;
  final String a2;
  final String a3;
  final String a4;

  final _ColorCallBack colorFunction;
  final Function(int) activeCallBack;

  _CreateAnswers(this.a1, this.a2, this.a3, this.a4, this.colorFunction, this.activeCallBack);

  @override
  _CreateAnswersState createState() => _CreateAnswersState(a1, a2, a3, a4, colorFunction, activeCallBack);
}

class _CreateAnswersState extends State<_CreateAnswers> {

  final String a1;
  final String a2;
  final String a3;
  final String a4;

  final _ColorCallBack colorFunction;

  final Function(int) callBack;

  _CreateAnswersState(
      this.a1,
      this.a2,
      this.a3,
      this.a4,
      this.colorFunction,
      this.callBack
      );

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _AnswerText(a1, 0, colorFunction(0), callBack)),
            Expanded(child: _AnswerText(a2, 1, colorFunction(1), callBack)),
            Expanded(child: _AnswerText(a3, 2, colorFunction(2), callBack)),
            Expanded(child: _AnswerText(a4, 3, colorFunction(3), callBack)),
          ],
        )
    );
  }
}

/// Create the three alternatives used to answer questions.
///
/// Has arguments three strings which shows that to display
class _CreateFollowUpAnswers extends StatefulWidget {
  Color color;
  final int a1;

  _CreateFollowUpAnswers(this.a1, this.color);

  @override
  _CFUAState createState() => _CFUAState(a1, color);
}

class _CFUAState extends State<_CreateFollowUpAnswers> {
  Color color;
  final int a1;

  _CFUAState(this.a1, this.color);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _FollowUpAnswerText(a1*3+1, color)),
            Expanded(child: _FollowUpAnswerText(a1*3+2, color)),
            Expanded(child: _FollowUpAnswerText(a1*3+3, color)),
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
class _AnswerText extends StatefulWidget {
  final String atext;
  Color color;
  final int number;
  final Function(int) callBack;

  _AnswerText(this.atext, this.number, this.color, this.callBack);

  @override
  _ATState createState() => _ATState(this.atext, this.number, this.color, this.callBack);
}

class _ATState extends State<_AnswerText> {
  final String atext;
  Color color;
  final int number;
  final Function(int) callBack;

  _ATState(this.atext, this.number, this.color, this.callBack);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column (
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: color,
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  //setState(() => _followUpVisibility = !_followUpVisibility);
                  print('$number : answertext');
                  callBack(number);
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Text(
                      atext,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }
}

/// Creates a single FollowupAnswerText object
///
/// Argument: a string
class _FollowUpAnswerText extends StatefulWidget {
  final Color color;
  final int number;

  _FollowUpAnswerText(this.number, this.color);

  @override
  _FUATState createState() => _FUATState(this.number, this.color);
}

class _FUATState extends State<_FollowUpAnswerText> {
  final Color color;
  final int number;
  bool colorToggle = false;

  _FUATState(this.number, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: colorToggle ? Colors.black : color,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          print('$number : followup');
          setState(() => colorToggle = !colorToggle);
        },
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
    );
  }
}
