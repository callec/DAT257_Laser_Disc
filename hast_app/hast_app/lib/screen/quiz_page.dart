import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hast_app/colors.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/screen/footer.dart';
import 'package:hast_app/screen/undefined_page.dart';
import 'package:hast_app/screen/responsive_page.dart';
import 'package:hast_app/screen/undefined_page.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

/// A function that takes an int and returns a Color.
typedef _ColorCallBack = Color Function(int n);

/// Displays a single question, and its respective alternatives
/// Also enables the navigation between questions
class QuizPage extends StatelessWidget {
  /// Display color depending on alternative index
  static Color getAlternativeColors(int n) {
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

    return WillPopScope(onWillPop: () => Future.value(false),
    child:
      Scaffold(
        appBar: AppBar(
          //title: Text(context.read<QuizModel>().title),
          title: HastLogo(),
          backgroundColor: theme.backgroundColor,
          automaticallyImplyLeading: false, //removes "go back arrow"
        ),
        body: Container(
          // Background image, already precached
          constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
               image: AssetImage('assets/images/quizPageImage.png'),
               fit: BoxFit.cover)),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: SizedBox(
                      width: ResponsivePage.isLargeScreen(context) ? 1000 : null,
                      child: Container(
                        // This is the white box!
                        // larger bot padding due to footer
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        constraints: ResponsivePage.isLargeScreen(context)
                            ? BoxConstraints(
                              // Size of the white box, height not specified
                              /*minWidth: MediaQuery.of(context).size.width * 0.5,
                              maxWidth: MediaQuery.of(context).size.width * 0.7,*/
                            )
                            : BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                              maxWidth: MediaQuery.of(context).size.width,
                            ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92), //Om vi vill ha lite genomskinlig box.
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Consumer<QuizModel>(
                          // TODO maybe it would be better to rebuild individual Text widgets
                          // within the larger widgets?
                          builder: (context, model, child) =>
                            Column(
                              children: !model.quizLoaded
                                  ? [UndefinedPage()]
                                  : [
                                    ResponsivePage.isSmallScreen(context) //Progressbar over the questions
                                    ? Text("")
                                      : Row(children: <Widget>[Spacer(), _CreateProgressIndicators(model), Spacer()]),
                                    _QuestionText( // Question and alternatives
                                      model.currentQuestion.question),
                                    _CreateAnswers(model.currentQuestion),
                                    model.currentQuestion.chosenAlternative != -1
                                        ? Visibility(
                                          visible: true,
                                          child: _subAltTitle(context))
                                        : Visibility(
                                          visible: false,
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: _subAltTitle(context)),
                                    model.currentQuestion.chosenAlternative != -1
                                        ? Visibility(
                                          visible: true,
                                          child: _subAlt(context, model))
                                        : Visibility(
                                          visible: false,
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: _subAlt(context, model)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 16),
                                      child: _CreateNextBackRow(model))
                                  ]))),
                )))]),),
              SliverFillRemaining(
                hasScrollBody: false,
                child: HastFooter()
    )
    ]))));
  }

  ///Padding and the creation of the follow up answers
  Widget _subAlt(context, model) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _CreateFollowUpAnswers(model));
  }

}

/// Padding and the the text for the follow up answers
Widget _subAltTitle(context) {
  return Padding(
      padding:
      const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Text(
          "Is your situation worse, better, or exactly as the chosen statement describes?",
          style: new TextStyle(fontSize: 18)));
}

/// Create a row of IconButtons that display progress
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
      progressBar.add(IconButton(
          icon: _getDotIcon(i), onPressed: () => _model.setQuestion(i)));
    }

    return progressBar;
  }
}

/// The row containing the back/next buttons and the progress indicator dots
class _CreateNextBackRow extends StatelessWidget {
  final QuizModel _model;

  _CreateNextBackRow(this._model);

  // not sure if disabledGrey is used elsewhere so won't change it
  var _disabledColor = disabledGrey.shade300;
  var _enabledColor = traverseGrey;
  var _nextColor = hastGreen;

  Color _nextButtonColor() {
    if (_model.currentNumber == _model.numberOfQuestions - 1) {
      if (_model.finished) {
        return _nextColor;
      } else {
        return _disabledColor;
      }
    } else if (_model.hasAnswered) {
      return _nextColor;
    } else {
      return _disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ElevatedButton(
        style: TextButton.styleFrom(
            primary: Theme.of(context).backgroundColor,
            backgroundColor: (_model.currentNumber == 0)
                ? _disabledColor
                : _enabledColor),
        onPressed: () {
          if (_model.currentNumber >= 1) {
            _model.prevQuestion();
          }
        },
        child: Text('Back'),
      ),
      Spacer(),
      // Progress indication (dots)
      Spacer(),
      ElevatedButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: _nextButtonColor(),
        ),
        onPressed: () {
          if (!_model.hasAnswered) return;
          if (_model.currentNumber <= _model.numberOfQuestions - 2) {
            _model.nextQuestion();
          } else if (_model.currentNumber == _model.numberOfQuestions - 1 && _model.finished) {
            Navigator.pushNamed(context, ResultRoute);
          }
        },
        child: Text(_model.currentNumber < _model.numberOfQuestions - 1 ? 'Next' : 'Result'),
      )]);
  }
}

/// Create a row of _AnswerText objects that are displayed on the screen.
/// Has arguments: color function and QuestionContent object
class _CreateAnswers extends StatelessWidget {
  final QuestionContent question;
  final _ColorCallBack colorFunction = QuizPage.getAlternativeColors;

  _CreateAnswers(this.question);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: ResponsivePage.isLargeScreen(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildAnswers())
            : Column( //when the page becomes smaller than 800 width the questions are in a column instead
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
      tempList.add(_AlternativeText(
              question.alternatives[x],
              x,
              colorFunction(alternativeBeenChosen
                  ? (alternativeNumber == x ? x : -1)
                  : x)));
    }
    return tempList;
  }
}

/// Create the three alternatives used to answer questions.
/// Has arguments: color function and QuestionContent object
class _CreateFollowUpAnswers extends StatelessWidget {
  final _ColorCallBack color = QuizPage.getAlternativeColors;
  final QuizModel model;
  late final QuestionContent question;

  _CreateFollowUpAnswers(this.model) {
    question = model.currentQuestion;
  }

  @override
  Widget build(BuildContext context) {
    var _salt = _buildSubAlternatives();
    return IntrinsicHeight(
        key: UniqueKey(),
        child: ResponsivePage.isMediumScreen(context)
          ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _salt,
          )
          : Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _salt,
          ));
  }

  List<Widget> _buildSubAlternatives() {
    List<Widget> tempList = [];

    //Have a alternative been chosen?
    bool _subAltBeenChosen = question.chosenSubAlternative != -1;

    int alternativeNumber = question.chosenAlternative;
    int subAlternativeNumber = question.chosenSubAlternative;
    List<String> options = model.subAlternatives;

    //Create three sub alternatives
    for (int x = 0; x < 3; x++) {
      tempList.add(Expanded(
          child: _SubAlternativeText(
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
    return Expanded(
      child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: Colors.black,
          ),
          onPressed: () {
            // Set chosen alternative in the QuizModel
            context.read<QuizModel>().setAlternative(number);
            context.read<QuizModel>().setSubAlternative(-1);
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Text(
                atext,
                style: Theme.of(context).textTheme.bodyText2,
              )),
        )),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
