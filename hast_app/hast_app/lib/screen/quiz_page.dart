import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hast_app/colors.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/screen/question_overview.dart';
import 'package:hast_app/screen/responsive_quiz_page.dart';

import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';

import 'home_page.dart';

/// A function that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n, [int intensity]);

/// Displays a single question, and its respective alternatives
/// Also enables the navigation between questions
class QuizPage extends StatelessWidget {

  /// Display color depending on alternative index
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          //title: Text(context.read<QuizModel>().title),
          title: HastLogo(),
          backgroundColor: theme.backgroundColor,
          automaticallyImplyLeading: false, //removes "go back arrow"
        ),

        body: Center(
            child: Container(
                // Background image, already precached
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/4.png'),
                        fit: BoxFit.cover)),
                child: Column(children: [


                  Container(
                    // This is the white box!
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),

                    constraints: ResponsiveQuizPage.isLargeScreen(context)
                    ? BoxConstraints(
                        //Size of the white box
                        minWidth: 900,
                        maxWidth: 1000,
                        minHeight: 320,
                        maxHeight: 440) : BoxConstraints(minWidth: 900, maxWidth: 1000, minHeight: 400, maxHeight: 800)
                    ,


                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Consumer<QuizModel>(
                        // TODO maybe it would be better to rebuild individual Text widgets
                        // within the larger widgets?
                        builder: (context, model, child) => Column(
                            children: model.loading ? [Text("LOADING")] : [
                              // Question and alternatives
                              _QuestionText(model.currentQuestion.question),
                              _CreateAnswers(_getColor, model.currentQuestion),
                              Spacer(),
                              /*Text(
                                  "How much do you agree to the chosen statement?",
                                  style: new TextStyle(fontSize: 18)),
                              _CreateFollowUpAnswers(
                                  _getColor, model.currentQuestion),*/
                              //TODO Out-commented code will make sub-alternatives invisible/visible
                              model.currentQuestion.chosenAlternative != -1
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 0),
                                      child: Text(
                                          "How much do you agree to the chosen statement?",
                                          style: new TextStyle(fontSize: 18)))
                                  : Text(""),
                              model.currentQuestion.chosenAlternative != -1
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: _CreateFollowUpAnswers(
                                          _getColor, model.currentQuestion))
                                  : Text(""),


                              Padding(
                                   padding:
                                       const EdgeInsets.only(left: 4, right: 4, bottom: 16),
                                  //TODO Balanserar ut next/back-knapparna med alternativen (kanske ta bort för att städa upp lite)
                                  child: _CreateNextBackRow(model))


                            ])),
                  )



                ]))));
  }
}

/// Create a row of IconButtons that display progress
///
///
class _CreateProgressIndicators extends StatelessWidget {
  final QuizModel _model;

  _CreateProgressIndicators(this._model);

  @override
  Widget build(BuildContext context) {
    return Row(children: _buildProgressIndicators());
  }

  // Provide the progress indicator dots with icon and color
  Icon _getDotIcon(int id) {
    bool isAnswered =
        _model.questions[id].chosenSubAlternative == -1 ? false : true;

    IconData icon = Icons.circle;
    Color color = dotGrey;

    if (isAnswered) {
      icon = Icons.check_circle;
      color = hastGreen;
    } else {
      icon = Icons.circle;
    }

    if (id == _model.currentNumber) {
      if (isAnswered) {
        color = hastDarkGreen;
      } else {
        color = hastGrey;
      }
    }

    return Icon(icon, color: color);
  }

  List<Widget> _buildProgressIndicators() {
    List<Widget> progressBar = [];

    for (int i = 0; i < _model.numberOfQuestions; i++) {
      progressBar.add( IconButton(
          icon: _getDotIcon(i), onPressed: () => _model.setQuestion(i)));
    }
    return progressBar;
  }
}

/// The row containing the back/next buttons and the progress indicator dots
class _CreateNextBackRow extends StatelessWidget {
  final QuizModel _model;

  _CreateNextBackRow(this._model);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(
          style: TextButton.styleFrom(
              primary: Theme.of(context).backgroundColor,
              backgroundColor: (_model.currentNumber == 0)
                  ? disabledGrey
                  : Theme.of(context).accentColor),
          onPressed: () {
            if (_model.currentNumber >= 1) {
              _model.prevQuestion();
            }
          },
          child: Text('Back'),
        ),
        Spacer(),
        // Progress indication (dots)
        _CreateProgressIndicators(_model),
        Spacer(),
        ElevatedButton(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: (_model.currentNumber == 7)
                ? (_model.finished ? hastGreen : disabledGrey)
                : Theme.of(context).accentColor,
          ),
          onPressed: () {
            if (_model.currentNumber <= 6) {
              _model.nextQuestion();
            } else if (_model.currentNumber == 7 && _model.finished) {
              Navigator.pushNamed(context, '/result');
            }
          },
          child: Text(_model.currentNumber < 7 ? 'Next' : 'Result'),
        ),
      ],
    );
  }
}

/// Create a row of _AnswerText objects that are displayed on the screen.
/// Has arguments: color function and QuestionContent object
class _CreateAnswers extends StatelessWidget {
  final QuestionContent question;
  final _ColorCallBack colorFunction;

  _CreateAnswers(this.colorFunction, this.question);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,

      children: _buildAnswers()
    ));
  }

  List<Widget> _buildAnswers() {
    List<Widget> tempList = [];
    int alternativeNumber = question.chosenAlternative;
    bool alternativeBeenChosen = alternativeNumber != -1;

    //Build Answer boxes
    for(int x = 0; x < question.alternatives.length; x++){
      tempList.add(
          Expanded(child:
            _AlternativeText(
              question.alternatives[x],
              x,
              colorFunction(alternativeBeenChosen
                  ? (alternativeNumber == x ? x : -1)
                  : x))));
    }
    return tempList;
  }
}

/// Create the three alternatives used to answer questions.
/// Has arguments: color function and QuestionContent object
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
    for(int x = 0; x < 3; x++) {
      tempList.add(
        Expanded(
          child: _SubAlternativeText(
            x,
            color(_subAltBeenChosen ?
              subAlternativeNumber == x ? alternativeNumber : -1 : alternativeNumber),
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
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(
          qtext,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

/// Creates a single Alternative object
/// Arguments: answer text, a number, a function
class _AlternativeText extends StatelessWidget {
  final String atext;
  final int number;
  final Color color;

  _AlternativeText(this.atext, this.number, this.color);

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
              onPressed: () { // Set chosen alternative in the QuizModel
                context.read<QuizModel>().setAlternative(number);
                context.read<QuizModel>().setSubAlternative(-1);
                //print('$number : answertext');
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Text(
                  atext,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ),
        )),
      ]),
    );
  }
}

/// Creates a single SubAlternative object
/// Argument: index (0,1,2), color and text
class _SubAlternativeText extends StatelessWidget {
  final int index;
  final Color color;
  final String text;

  _SubAlternativeText(this.index, this.color, this.text);

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
            //print('$number points');
            (context.read<QuizModel>().currentQuestion.chosenAlternative == -1)
                ? null
                : context.read<QuizModel>().setSubAlternative(index);
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
