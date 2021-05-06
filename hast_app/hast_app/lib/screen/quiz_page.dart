import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hast_app/colors.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/screen/question_overview.dart';

import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';

import 'home_page.dart';

/// A function that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

class QuizPage extends StatefulWidget {
  // maybe this can go into quiz_model?
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color _getColor(int n, [int intensity = 200]) {
    switch (n) {
      case 0:
        return hastAlt1;
      case 1:
        return hastAlt2;
      case 2:
        return hastAlt3;
      case 3:
        return hastAlt4;
      default:
        return altGrey;
    }
  }

  Icon _getDotIcon(int id, QuizModel model){

    bool isAnswered = model.questions[id].chosenSubAlternative == -1 ? false : true;

    IconData icon = Icons.circle;
    Color color = Colors.grey[400];

    if (isAnswered){
      icon = Icons.check_circle;
      color = hastGreen;
    } else{
      icon = Icons.circle;
    }

    if (id == model.currentNumber){

      if (isAnswered){
        color = hastDarkGreen;
      } else {
        color = hastGrey;
      }
    }

    return Icon(icon, color: color);
  }




  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          //title: Text(context.read<QuizModel>().title),
          title: HastLogga(),
          backgroundColor: theme.backgroundColor,
          automaticallyImplyLeading: false, //removes "go back arrow"
        ),
        body: Row(children: [
          Expanded(
              child: Center(
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/4.png'),
                              fit: BoxFit.cover)),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Consumer<QuizModel>(
                              // TODO maybe it would be better to rebuild individual Text widgets
                              // within the larger widgets?
                              builder: (context, model, child) =>
                                  Column(children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 16, 16, 16),
                                        child: Container(
                                          //color: Colors.pink,
                                          constraints: BoxConstraints(
                                              //TODO
                                              minWidth: 900,
                                              maxWidth: 1000,
                                              minHeight: 320,
                                              maxHeight: 400),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0.5,
                                                blurRadius: 1,
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 8, 0),
                                              child: Column(children: [
                                                _QuestionText(model
                                                    .currentQuestion.question),
                                                _CreateAnswers(_getColor,
                                                    model.currentQuestion),
                                                Spacer(),
                                                Padding(padding: const EdgeInsets.fromLTRB(0, 16, 0, 0), // TODO to restore old layout - remove this and uncomment commented code
                                                    child: Text("How much do you agree to the chosen statement?",
                                                        style: new TextStyle(fontSize:
                                                        18))),
                                                Padding(padding: const EdgeInsets.symmetric(horizontal: 128),
                                                    child: _CreateFollowUpAnswers(_getColor, model.currentQuestion)), //TODO remove to here
                                                /*model.currentQuestion.chosenAlternative != -1
                                                    ? Padding(padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                                        child: Text("How much do you agree to the chosen statement?",
                                                            style: new TextStyle(fontSize:
                                                                        18))) : Text(""),
                                                model.currentQuestion.chosenAlternative != -1
                                                    ? Padding(padding: const EdgeInsets.symmetric(horizontal: 128),
                                                        child: _CreateFollowUpAnswers(_getColor, model.currentQuestion))
                                                    : Text(""),*/
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 0, 8, 16),
                                                    //TODO Balanserar ut next/back-knapparna med alternativen (kanske ta bort för att städa upp lite)
                                                    child: Row(
                                                      children: <Widget>[
                                                        TextButton(style: TextButton.styleFrom(primary: theme.backgroundColor,
                                                            backgroundColor: (model.currentNumber == 0) ? disabledGrey : theme.accentColor),
                                                          onPressed: () {
                                                            if (model.currentNumber >= 1) {
                                                              model.prevQuestion();
                                                            }
                                                          },
                                                          child: Text('Back'),
                                                        ),
                                                        Spacer(),
                                                        Row(children: [
                                                          IconButton(icon: _getDotIcon(0, model), onPressed: () => model.setQuestion(0)),
                                                            IconButton(icon: _getDotIcon(1, model), onPressed: () => model.setQuestion(1)),
                                                            IconButton(icon: _getDotIcon(2, model), onPressed: () => model.setQuestion(2)),
                                                            IconButton(icon: _getDotIcon(3, model), onPressed: () => model.setQuestion(3)),
                                                            IconButton(icon: _getDotIcon(4, model), onPressed: () => model.setQuestion(4)),
                                                            IconButton(icon: _getDotIcon(5, model), onPressed: () => model.setQuestion(5)),
                                                            IconButton(icon: _getDotIcon(6, model), onPressed: () => model.setQuestion(6)),
                                                          IconButton(icon: _getDotIcon(7, model), onPressed: () => model.setQuestion(7)),
                                                        ],),
                                                        Spacer(),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.white,
                                                            backgroundColor: (model
                                                                        .currentNumber ==
                                                                    7)
                                                                ? (model.finished
                                                                    ? hastGreen
                                                                    : disabledGrey)
                                                                : theme
                                                                    .accentColor,
                                                          ),
                                                          onPressed: () {
                                                            if (model
                                                                    .currentNumber <=
                                                                6) {
                                                              model
                                                                  .nextQuestion();
                                                            } else if (model
                                                                        .currentNumber ==
                                                                    7 &&
                                                                model
                                                                    .finished) {
                                                              Navigator
                                                                  .pushNamed(
                                                                      context,
                                                                      '/result');
                                                            }
                                                          },
                                                          child: Text(
                                                              model.currentNumber <
                                                                      7
                                                                  ? 'Next'
                                                                  : 'Result'),
                                                        ),
                                                      ],
                                                    ))
                                              ])),
                                        ))
                                  ]))))))
        ]));
  }
}

/// Create a row of _AnswerText objects that are displayed on the screen.
///
/// Has arguments 4 strings and a function.
class _CreateAnswers extends StatelessWidget {
  final QuestionContent question;
  final _ColorCallBack colorFunction;

  //Send in question instead?
  _CreateAnswers(this.colorFunction, this.question);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildAnswers()));
  }

  List<Widget> _buildAnswers() {
    List<Widget> tempList = [];
    int alternativeNumber = question.chosenAlternative;
    bool alternativeBeenChosen = alternativeNumber != -1;

    //Build Answer boxes
    for (int x = 0; x < question.alternatives.length; x++) {
      tempList.add(Expanded(
          child: _AnswerText(
              question.alternatives[x],
              x,
              colorFunction(alternativeBeenChosen
                  ? alternativeNumber == x
                      ? x
                      : -1
                  : x))));
    }
    return tempList;
  }
}

/// Create the three alternatives used to answer questions.
///
/// Has arguments three strings which shows that to display
class _CreateFollowUpAnswers extends StatelessWidget {
  final _ColorCallBack color;
  final QuestionContent question;

  _CreateFollowUpAnswers(this.color, this.question);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        key: UniqueKey(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildSubAlternatives(),
        ));
  }

  List<Widget> _buildSubAlternatives() {
    List<Widget> tempList = [];

    //Have a alternative been chosen?
    bool _subAltBeenChosen = question.chosenSubAlternative != -1;

    int alternativeNumber = question.chosenAlternative;
    int subAlternativeNumber = question.chosenSubAlternative;
    List<String> options = question.subAlternatives;

    //Create three sub alternatives
    for (int x = 0; x < 3; x++) {
      tempList.add(Expanded(
          child: _FollowUpAnswerText(
              alternativeNumber * 3 + (x + 1),
              x,
              color(_subAltBeenChosen
                  ? subAlternativeNumber == x
                      ? alternativeNumber
                      : -1
                  : alternativeNumber),
              options[x])));
    }

    return tempList;
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
      //color: Colors.amber,
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
                style: Theme.of(context).textTheme.bodyText2,
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
            (context.read<QuizModel>().currentQuestion.chosenAlternative == -1) ? null : context.read<QuizModel>().setSubAlternative(index);
          },
          child: Container(
              color: Colors.transparent,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText2,
                  ))),
        ));
  }
}
