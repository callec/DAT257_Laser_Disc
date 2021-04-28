import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';

/// A function that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

class QuizPage extends StatelessWidget {
  // maybe this can go into quiz_model?
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
        title: Text(context.read<QuizModel>().title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Consumer<QuizModel>(
            // TODO maybe it would be better to rebuild individual Text widgets
            // within the larger widgets?
            builder: (context, model, child) => Column(children: [
                _QuestionText(model.currentQuestion.question),
                _CreateAnswers(
                  _getColor, model.currentQuestion.alternatives),
                  model.currentQuestion.chosenAlternative != -1
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Text("How much do you agree to the chosen statement?",
                            style: new TextStyle(fontSize: 18)))
                      : Text(""),
                  model.currentQuestion.chosenAlternative != -1
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 128),
                      child: _CreateFollowUpAnswers(
                        model.currentQuestion.chosenAlternative,
                        _getColor(
                          model.currentQuestion.chosenAlternative),
                        model.currentQuestion.subAlternatives))
                    : Text(""),
                Spacer(),
                Row(
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: (model.currentNumber == 0)
                        ? Colors.grey
                        : Colors.red[800],
                      ),
                      onPressed: () {
                        if (model.currentNumber >= 1) {
                          model.prevQuestion();
                        }
                      },
                      child: Text('Back'),
                    ),
                    Spacer(),
                    Text((model.currentNumber + 1).toString()),
                    Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: (model.currentNumber == 7)
                        ? Colors.green[800]
                        : Colors.red[800],
                      ),
                      onPressed: () {
                        if (model.currentNumber <= 6) {
                          model.nextQuestion();
                        } else if (model.currentNumber == 7) {
                          Navigator.pushNamed(context, '/result');
                        }
                      },
                      child: Text(model.currentNumber < 7 ? 'Next' : 'Result'),
                    ),
                  ],
                )
              ]
            )
          )
        )
      )
    );
  }
}

/// Create a row of _AnswerText objects that are displayed on the screen.
///
/// Has arguments 4 strings and a function.
class _CreateAnswers extends StatelessWidget {
  final List<String> alternatives;

  final _ColorCallBack colorFunction;

  _CreateAnswers(this.colorFunction, this.alternatives);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _AnswerText(alternatives[0], 0, colorFunction(0))),
          Expanded(child: _AnswerText(alternatives[1], 1, colorFunction(1))),
          Expanded(child: _AnswerText(alternatives[2], 2, colorFunction(2))),
          Expanded(child: _AnswerText(alternatives[3], 3, colorFunction(3))),
        ],
      )
    );
  }
}

/// Create the three alternatives used to answer questions.
///
/// Has arguments three strings which shows that to display
class _CreateFollowUpAnswers extends StatelessWidget {
  final Color color;
  final int a1;
  final List<String> options;

  _CreateFollowUpAnswers(this.a1, this.color, this.options);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      key: UniqueKey(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _FollowUpAnswerText(a1 * 3 + 1, color, options[0])),
          Expanded(child: _FollowUpAnswerText(a1 * 3 + 2, color, options[1])),
          Expanded(child: _FollowUpAnswerText(a1 * 3 + 3, color, options[2])),
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
  final Color color;
  final int number;

  _AnswerText(this.atext, this.number, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Column(
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
                context.read<QuizModel>().setAlternative(number);
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
            )
          ),
        ]
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
          context.read<QuizModel>().setSubAlternative(number);
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
            )
          )
        ),
      )
    );
  }
}
