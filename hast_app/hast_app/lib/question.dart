import 'package:flutter/material.dart';

/// A function used in many places that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

class QuestionContent {
  String questionText = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  QuestionContent(this.questionText, this.option1, this.option2, this.option3,
      this.option4);
}

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

String subOption1 = '1';
String subOption2 = '2';

String subOption3 = '3';

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

String nextButton = "Next";


class Question extends StatefulWidget {
  Question() {
    question_number = 0;

    _updateQuestionContent();
  }

  _updateQuestionContent() {
    //Add question 1 text
    questionList.insert(0, new QuestionContent(
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

  @override
  Widget build(BuildContext context) {

    if (question_number == 7){
      nextButton = 'Result';
    } else
      nextButton = 'Next';

    QuestionContent currentQuestion = questionList[question_number];

    return Scaffold(
        appBar: AppBar(
          title: Text(question_title),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: <Widget>[
                _QuestionText(currentQuestion.questionText),
                _CreateAnswers(
                    currentQuestion.option1,
                    currentQuestion.option2,
                    currentQuestion.option3,
                    currentQuestion.option4,
                    _getColor),
                //_CreateFollowUpAnswers(0)
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
                    child: Row(
                      children: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                              return Colors.white;
                            }),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                              return Colors.red[800];
                            }),
                          ),
                          onPressed: () {
                            if (question_number >= 1) {
                              question_number--; //TODO
                              setState(() {});
                            }
                          },
                          child: Text('Back'),
                        ),
                        Spacer(),
                        Text((question_number+1).toString()),
                        Spacer(),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                              return Colors.white;
                            }),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (Set<MaterialState> states) {
                              return Colors.red[800];
                            }),
                          ),
                          onPressed: () {
                            if (question_number <= 6) {
                              question_number++; //TODO
                              setState(() {});
                            } else if (question_number == 7) {
                              Navigator.pushNamed(context, '/result');
                            }
                          },
                          child: Text(nextButton),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ])));
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
    ));
  }
}

/// Create the three alternatives used to answer questions.
///
/// Has arguments three strings which shows that to display
class _CreateFollowUpAnswers extends StatelessWidget {
  final _ColorCallBack colorFunction;
  final int a1;

  _CreateFollowUpAnswers(this.a1, this.colorFunction);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: _FollowUpAnswerText(a1 * 3 + 1, colorFunction(a1, 300))),
        Expanded(
            child: _FollowUpAnswerText(a1 * 3 + 2, colorFunction(a1, 300))),
        Expanded(
            child: _FollowUpAnswerText(a1 * 3 + 3, colorFunction(a1, 300))),
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
  final _ColorCallBack colorFunction;
  final int number;

  _AnswerText(this.atext, this.number, this.colorFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Container(
        color: colorFunction(number),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                atext,
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
          Spacer(),
          _CreateFollowUpAnswers(number, colorFunction)
        ]),
      ),
    );
  }
}

/// Creates a single FollowupAnswerText object
///
/// Argument: a string
class _FollowUpAnswerText extends StatelessWidget {
  final Color color;
  final int number;

  _FollowUpAnswerText(this.number, this.color);

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
                  '$number',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ))),
      ),
    );
  }
}
