import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:provider/provider.dart';

/// Displays the score from the Quiz and a conclusion text

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultModel _result = context.watch<ResultModel>(); // Load Result model
    final String _scoreText = _result.text;
    final int _score = _result.score;
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Score: $_score',
              textAlign: TextAlign.center,
              style: theme.textTheme.headline4),
          SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('$_scoreText',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline5)),
          SizedBox(height: 100),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return theme.backgroundColor;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return theme.accentColor;
              }),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('Home'),
          )
        ])));
  }
}
