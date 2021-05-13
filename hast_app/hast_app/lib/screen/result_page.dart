import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:hast_app/screen/home_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays the score from the Quiz and a conclusion text
class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultModel _result = context.watch<ResultModel>(); // Load Result model
    final _theme = Theme.of(context);
    var _scrollController = new ScrollController();

    final _url = 'https://www.hastutveckling.se'; // TODO set to HAST specified link
    final _buttonText = 'Click here to learn more about HAST International'; // TODO set to HAST specified text

    var _windowHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    double _fixedHeight = 1000; // TODO set to relevant value with embed
    var _large = _windowHeight > _fixedHeight;

    return Scaffold(
        appBar: AppBar(
          title: HastLogo(),
          automaticallyImplyLeading: false,
          backgroundColor: _theme.backgroundColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: _large ? _windowHeight : _fixedHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      _PointsAndText(_result, _theme),
                      SizedBox(height: 20),
                      //_Embed(_data),
                      _HastButton(_theme, _buttonText, _url),
                      _large ? Spacer() : SizedBox(height: 20,),
                      _large ? _scrollButton(_scrollController) : _ResultOverview(_result, _theme),
                    ]
                  )
                ),
                !_large ? Container() : SizedBox(
                  height: _windowHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      _ResultOverview(_result, _theme),
                    ]
                  )
                )
              ]
            )
          )
        )
    );
  }

  /// Return a clickable text that scrolls to bottom
  Widget _scrollButton(ScrollController _scrollController) {
    return InkWell(
      onTap: () {
        // the check doesn't work properly
        var scrollPosition = _scrollController.position;

        //if (scrollPosition.viewportDimension < scrollPosition.maxScrollExtent) {
          _scrollController.animateTo(
            scrollPosition.maxScrollExtent,
            duration: new Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        //}
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Scroll down to see more information about Your result',
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        )
      )
    );
  }
}

/// Embedded HTML
class _Embed extends StatelessWidget {
  final String _data;

  _Embed(this._data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

/// Displays points out of max and corresponding text
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
          Text('Your score is: $_score' + '/' + '${_numberOfQuestions * 12}',
            textAlign: TextAlign.center,
            style: theme.textTheme.headline4),
          SizedBox(height: 30),
          Container(
            child: Text('$_scoreText',
              textAlign: TextAlign.justify, // TODO which is the best? TextAlign.center or justify?
              style: theme.textTheme.headline5)),
    ]));
  }
}

/// The column with question number, title, and amount of points for
/// your answer.
class _ResultOverview extends StatelessWidget {
  final _theme;
  final ResultModel _model;
  late final List<QuestionContent> _questions;

  _ResultOverview(this._model, this._theme) {
    this._questions = _model.questions;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: _theme.accentColor),
        child: Padding( //to get the overview in the middle and proper adjust when the window size is changed.
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.12,
            right: MediaQuery.of(context).size.width * 0.12),
            child: IgnorePointer( //wrapped in a IgnorePointer to remove clickable event
              child: DataTable(columns: const <DataColumn>[
                DataColumn(
                  label: Text('Question',
                    style: TextStyle(
                        fontStyle: FontStyle.italic
                    ))),
                DataColumn(
                  label: Text('Text',
                    style: TextStyle(
                        fontStyle: FontStyle.italic
                    ))),
                DataColumn(
                  label: Text('Score',
                    style: TextStyle(
                        fontStyle: FontStyle.italic
                    ))),
                  ],
                  rows: _questions.map(((element) => DataRow(
                    // Loops through dataColumnText, each iteration assigning the value to element
                    // fills the dataTable with data from the list.
                    cells: <DataCell>[
                      DataCell(Text("      " + element.number.toString())),
                      DataCell(Text(element.question)),
                      DataCell(Text(
                          ((element.chosenSubAlternative + 1)
                              + element.chosenAlternative * 3)
                                      .toString() + "/12"))
                            ],
                          )
                  )).toList()
                )
              )
            )
    );
  }
}

/// A button that redirects to a specified link
class _HastButton extends StatelessWidget {
  /// Directs you to a specified page, requires url_launch package
  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  final _theme;
  final _text;
  final _url;

  _HastButton(this._theme, this._text, this._url);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //height: 40, // no height specified for button on home_page
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
            _launchURL(_url);
          },
          child: Text('  '+_text+'  '),
        )
    );
  }
}

/// Button that redirects you to the start page
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
