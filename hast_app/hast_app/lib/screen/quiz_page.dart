import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hast_app/MainPage.dart';
import 'package:hast_app/common/question.dart';
import 'package:hast_app/questionDrawer.dart';
import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';

/// A function that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

class QuizPage extends StatelessWidget {
  // maybe this can go into quiz_model?
  Color _getColor(int n, [int intensity = 200]) {
    switch (n) {
      case 0:
        return Color.fromARGB(255, 246, 207, 30);
      case 1:
        return Color.fromARGB(255, 255, 189, 84);
      case 2:
        return Color.fromARGB(255, 255, 151, 74);
      case 3:
        return Color.fromARGB(255, 255, 103, 86);
      default:
        return Colors.grey[intensity];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: hastLogga(),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false, //removes "go back arrow"
        ),
        body: Row(children: [
          QuestionDrawer(),
          Expanded(
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Consumer<QuizModel>(
                          // TODO maybe it would be better to rebuild individual Text widgets
                          // within the larger widgets?
                          builder: (context, model, child) => Column(children: [
                                _QuestionText(model.currentQuestion.question),
                                _CreateAnswers(_getColor,
                                    model.currentQuestion),
                                model.currentQuestion.chosenAlternative != -1
                                    ? _CreateFollowUpAnswers(
                                        model.currentQuestion.chosenAlternative,
                                        _getColor(model
                                            .currentQuestion.chosenAlternative),
                                        model.currentQuestion.subAlternatives, model.currentQuestion)
                                    : Text(""),
                                Spacer(),
                                Row(
                                  children: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor:
                                            (model.currentNumber == 0)
                                                ? Colors.grey
                                                : Color.fromARGB(255,255, 49, 34),
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
                                        backgroundColor:
                                            (model.currentNumber == 7)
                                                ? Colors.green[800]
                                                : Color.fromARGB(255,255, 49, 34),
                                      ),
                                      onPressed: () {
                                        if (model.currentNumber <= 6) {
                                          model.nextQuestion();
                                        } else if (model.currentNumber == 7) {
                                          Navigator.pushNamed(
                                              context, '/result');
                                        }
                                      },
                                      child: Text(model.currentNumber < 7
                                          ? 'Next'
                                          : 'Result'),
                                    ),
                                  ],
                                )
                              ])))))
        ]));
  }
}

/// Create a row of _AnswerText objects that are displayed on the screen.
///
/// Has arguments 4 strings and a function.
class _CreateAnswers extends StatelessWidget {
  final QuestionContent question;
  final _ColorCallBack colorFunction;
  bool alternativeBeenChosen;

//  final Function(int) followUpCallBack;

  //Send in question instead?
  _CreateAnswers(this.colorFunction, this.question){
     alternativeBeenChosen = question.chosenAlternative != -1;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Expanded(child: _AnswerText(question.alternatives[0], 0, colorFunction(alternativeBeenChosen ? question.chosenAlternative == 0 ? 0 : -1 : 0))),
        Expanded(child: _AnswerText(question.alternatives[1], 1, colorFunction(alternativeBeenChosen ? question.chosenAlternative == 1 ? 1 : -1 : 1))),
        Expanded(child: _AnswerText(question.alternatives[2], 2, colorFunction(alternativeBeenChosen ? question.chosenAlternative == 2 ? 2 : -1 : 2))),
        Expanded(child: _AnswerText(question.alternatives[3], 3, colorFunction(alternativeBeenChosen ? question.chosenAlternative == 3 ? 3 : -1 : 3))),

        //if(har vi valt alternativ)
            //if(är det mitt alterntivt?)
              //sätt min färg
            //else
                //Sätt mig grå
        //sätt min färg
        //

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
  final List<String> options;
  final QuestionContent question;
  bool _subAlternativeBeenChosen;

  _CreateFollowUpAnswers(this.a1, this.color, this.options, this.question){
    _subAlternativeBeenChosen = question.chosenSubAlternative != -1;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        key: UniqueKey(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _FollowUpAnswerText(a1 * 3 + 1, 0, _subAlternativeBeenChosen ? question.chosenSubAlternative == 0 ? color : Colors.grey[200] :color , options[0])),
            Expanded(child: _FollowUpAnswerText(a1 * 3 + 2, 1, _subAlternativeBeenChosen ? question.chosenSubAlternative == 1 ? color : Colors.grey[200] :color , options[1])),
            Expanded(child: _FollowUpAnswerText(a1 * 3 + 3, 2,  _subAlternativeBeenChosen ? question.chosenSubAlternative == 2 ? color : Colors.grey[200] :color , options[2])),
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
      color: Colors.white,
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
            context.read<QuizModel>().setAlternative(number);
            context.read<QuizModel>().setSubAlternative(null);
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                atext,
                style: TextStyle(
                  fontSize: 14,
                ),
              )),
        )),
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
  final int index;

  _FollowUpAnswerText(this.number, this.index, this.color, this.text);

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
            context.read<QuizModel>().setSubAlternative(index);
            print('$index index');
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
        ));
  }
}
