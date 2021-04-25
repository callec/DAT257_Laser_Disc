import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A function used in many places that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

List questionList = [];
int question_number = 0;

String question_title = 'Lifestyle and Work Assessment';

String question1_text = 'Reactivity vs. finding \'the space\'';

String option1_1 = 'You often overreact to other people, since you are often '
    'treated unfairly. Sometimes you feel the world is against you.';

String option1_2 = 'You see that you react in ways that don’t work in many '
    'situations. You don’t feel good about it, but you have no idea how to '
    'change your behaviour.';

String option1_3 = 'You often catch yourself when you overreact, you find ‘the '
    'space’, and from there you can create a more balanced response.';

String option1_4 =
    'As you let your reactions be instead of trying to change them,'
    '  you often get insights and see new possibilities.';

String question2_title = 'Lifestyle and Work Assessment';

String question2_text = 'Relaxed or Stressed';

String option2_1 =
    'You are very stressed. You notice your physical health is suffering. You are not sure how long you can keep this up without going into Burnout.';

String option2_2 =
    'You are stressed most days; you are frequently anxious or worried and you are not sure what to do to change things for the better. Sometimes, you might feel a little better, but stress comes back very quickly.';

String option2_3 =
    'You have reached a place where you feel relaxed a lot of the time, even if you feel stressed now and again. You are alert for when you have stressful thinking and can move relatively easily beyond stress into relaxation.';

String option2_4 =
    'You are relaxed, yet responsive to what happens in life and you seem to be able to handle big and small challenges with grace and ease. Others wonder how you can be so productive and yet so relaxed.';

// fråga HAST ifall dessa ska vara konstanta
//Vad betyder egentligen graderingen som görs i fas två
String subOption1 = 'Alternative 1';
String subOption2 = 'Alternative 2';
String subOption3 = 'Alternative 3';

String nextButton = "Next";

class QuestionContent {
  String questionText = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  QuestionContent(this.questionText, this.option1, this.option2, this.option3,
      this.option4);
}

class Question extends StatefulWidget {
  Question() {
    question_number = 0;

    _updateQuestionContent();
  }

  _updateQuestionContent() {
    //Add question 1 text
    questionList.insert(
        0,
        new QuestionContent(
            question1_text, option1_1, option1_2, option1_3, option1_4));

    //Add question 2 text
    questionList.insert(
        1,
        new QuestionContent(
            question2_text, option2_1, option2_2, option2_3, option2_4));

    //Add question 3 text
    questionList.insert(
        2,
        new QuestionContent(
            question1_text, option1_1, option1_2, option1_3, option1_4));

    //Add question 4 text
    questionList.insert(
        3,
        new QuestionContent(
            question2_text, option2_1, option2_2, option2_3, option2_4));

    //Add question 5 text
    questionList.insert(
        4,
        new QuestionContent(
            question1_text, option1_1, option1_2, option1_3, option1_4));

    //Add question 6 text
    questionList.insert(
        5,
        new QuestionContent(
            question2_text, option2_1, option2_2, option2_3, option2_4));

    //Add question 7 text
    questionList.insert(
        6,
        new QuestionContent(
            question1_text, option1_1, option1_2, option1_3, option1_4));

    //Add question 8 text
    questionList.insert(
        7,
        new QuestionContent(
            question2_text, option2_1, option2_2, option2_3, option2_4));
  }

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
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

  /* TODO:
   *  - Answer gray out if not chosen
   *  - followupanswer gray out if not chosen
   */

  bool _displayFollowUp = false;
  int _followUpValue = -1;

  void followUpCallBack(int n) {
    setState(() {
      if (_followUpValue == n) {
        _displayFollowUp = false;
        _followUpValue = -1;
      } else {
        _displayFollowUp = true;
        _followUpValue = n;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (question_number == 7) {
      nextButton = 'Result';
    } else
      nextButton = 'Next';

    QuestionContent currentQuestion = questionList[question_number];

    return Scaffold(
        appBar: AppBar(
          title: Text(question_title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: <Widget>[
                _QuestionText(currentQuestion.questionText),
                _CreateAnswers(
                    currentQuestion.option1,
                    currentQuestion.option2,
                    currentQuestion.option3,
                    currentQuestion.option4,
                    _getColor,
                    followUpCallBack),
                //_CreateFollowUpAnswers(0)
                _displayFollowUp
                    ? _CreateFollowUpAnswers(
                        _followUpValue,
                        _getColor(_followUpValue),
                        subOption1,
                        subOption2,
                        subOption3)
                    : Text(""),
                Spacer(),
                Row(
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: (question_number == 0) ? Colors.grey : Colors.red[800],
                      ),
                      onPressed: () {
                        if (question_number >= 1) {
                          question_number--;
                          _displayFollowUp = false; //TODO maybe change to be able to see which option you picked when going back
                          _followUpValue = -1;
                          //setState updates this widget
                          setState(() {});
                        }
                      },
                      child: Text('Back'),
                    ),
                    Spacer(),
                    Text((question_number + 1).toString()),
                    Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: (question_number == 7) ? Colors.green[800] : Colors.red[800],
                      ),
                      onPressed: () {
                        if (question_number <= 6) {
                          question_number++;
                          _displayFollowUp = false; //TODO maybe change to be able to see which option you picked when going back
                          _followUpValue = -1;
                          //setState updates this widget
                          setState(() {});
                        } else if (question_number == 7) {
                          Navigator.pushNamed(context, '/result');
                        }
                      },
                      child: Text(nextButton),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
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
  final Function(int) followUpCallBack;

  _CreateAnswers(this.a1, this.a2, this.a3, this.a4, this.colorFunction,
      this.followUpCallBack);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _AnswerText(a1, 0, colorFunction(0), followUpCallBack)),
        Expanded(child: _AnswerText(a2, 1, colorFunction(1), followUpCallBack)),
        Expanded(child: _AnswerText(a3, 2, colorFunction(2), followUpCallBack)),
        Expanded(child: _AnswerText(a4, 3, colorFunction(3), followUpCallBack)),
      ],
    ));
  }
}

/// Create the three alternatives used to answer questions.
///
/// Has arguments three strings which shows that to display
class _CreateFollowUpAnswers extends StatelessWidget {
  final Color color;
  final int a1;
  final String op1;
  final String op2;
  final String op3;

  _CreateFollowUpAnswers(this.a1, this.color, this.op1, this.op2, this.op3);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        key: UniqueKey(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _FollowUpAnswerText(a1 * 3 + 1, color, op1)),
            Expanded(child: _FollowUpAnswerText(a1 * 3 + 2, color, op2)),
            Expanded(child: _FollowUpAnswerText(a1 * 3 + 3, color, op3)),
          ],
        ));
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
  final Color color;
  final int number;
  final Function(int) followUpCallBack;

  _AnswerText(this.atext, this.number, this.color, this.followUpCallBack);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Column(children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: Colors.black,
            ),
            onPressed: () {
              //setState(() => _followUpVisibility = !_followUpVisibility);
              print('$number : answertext');
              followUpCallBack(number);
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  atext,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}

/// Creates a single FollowupAnswerText object
///
/// Argument: a string
class _FollowUpAnswerText extends StatelessWidget {
  final Color color;
  final int number;
  final String text;

  _FollowUpAnswerText(this.number, this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.black,
        ),
        onPressed: () {
          print('$number points');
        },
        child: Container(
            color: Colors.transparent,
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ))),
      ),
    );
  }
}
