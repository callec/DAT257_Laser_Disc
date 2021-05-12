import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:hast_app/screen/home_page.dart';
import 'package:provider/provider.dart';

/// Displays the score from the Quiz and a conclusion text
class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultModel _result = context.watch<ResultModel>(); // Load Result model
    //list used to access score per question, question title and question number, for the overview.
    List<QuestionContent> _questions = _result.questions;
    final _theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          //title: Text(context.read<QuizModel>().title),
          title: HastLogo(),
          automaticallyImplyLeading: false,
          backgroundColor: _theme.backgroundColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 1000,//MediaQuery.of(context).size.height * 2, // TODO make sure this fits every result text
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  _PointsAndText(_result, _theme),
                  //SizedBox(height: 20),
                  //Spacer(),
                  _HastButton(_theme),
                  _ResultOverview(_result, _theme),
                  //SizedBox(height: 20),
                  //_HomeButton(_theme),
                  //SizedBox(height: 20),
        ])))));
  }
}

class _PointsAndText extends StatelessWidget {
  final ResultModel _model;
  final theme;
  late final int _score;
  late final String _scoreText;
  late final int _numberOfQuestions;

  _PointsAndText(this._model, this.theme) {
    _score = _model.score;
    _scoreText = _model.text;
    _numberOfQuestions = _model.questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return Padding( //to get the overview in the middle and proper adjust when the window size is changed.
      padding: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.12,
      right: MediaQuery.of(context).size.width * 0.12),
      child: Column(
        children: [
          Text('Your score is: $_score' + '/' + '${_numberOfQuestions * 12}', //The final score after a evaluation.
            textAlign: TextAlign.center,
            style: theme.textTheme.headline4),
          SizedBox(height: 30),
          Container(
            //width: MediaQuery.of(context).size.width - 100,
            child: Text('$_scoreText',
              textAlign: TextAlign.justify, // TODO which is the best? TextAlign.center or justify?
              style: theme.textTheme.headline5)),
    ]));
  }
}

class _ResultOverview extends StatelessWidget {
  final _theme;
  final ResultModel _model;
  late final List<QuestionContent> _questions;

  _ResultOverview(this._model, this._theme) {
    this._questions = _model.questions;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: //the overview
      Theme(
        data: Theme.of(context).copyWith(dividerColor: _theme.accentColor),
        child: Padding( //to get the overview in the middle and proper adjust when the window size is changed.
            padding: EdgeInsets.only(
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.12,
                right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.12),
            child: ListView( //wrapped in a listView to be scrollable.
                children: <Widget>[
                  IgnorePointer( //wrapped in a IgnorePointer to remove clickable event
                      child: DataTable(columns: const <DataColumn>[
                        DataColumn(
                            label: Text('Question',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                        DataColumn(
                            label: Text('Text',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                        DataColumn(
                            label: Text('Score',
                                style: TextStyle(fontStyle: FontStyle.italic))),
                      ],
                          rows: _questions.map(((element) =>
                              DataRow( // Loops through dataColumnText, each iteration assigning the value to element
                                //fills the dataTable with data from the list.
                                cells: <DataCell>[
                                  DataCell(Text(
                                      "      " + element.number.toString())),
                                  DataCell(Text(element.question)),
                                  DataCell(Text(
                                      ((element.chosenSubAlternative + 1) +
                                          element.chosenAlternative * 3)
                                          .toString() + "/12"))
                                ],
                              ))).toList()))
                ]
            )
        )
    )
    );
  }
}

class _HastButton extends StatelessWidget {
  final _theme;

  _HastButton(this._theme);

  @override
  Widget build(BuildContext context) {
    return SizedBox(//button wrapped in sizeBox to be able to change its size.
        width: 100, height: 40,
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return _theme.backgroundColor;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return _theme.accentColor;
            }),
          ),
          onPressed: () {
            // TODO redirect to HAST
          },
          child: Text('HAST International'),
        )
    );
  }
}

class _HomeButton extends StatelessWidget {
  final _theme;

  _HomeButton(this._theme);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(//button wrapped in sizeBox to be able to change its size.
        width: 100, height: 40,
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return _theme.backgroundColor;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return _theme.accentColor;
            }),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Text('Home'),
        )
    );
  }
}
