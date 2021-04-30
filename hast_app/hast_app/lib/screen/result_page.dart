import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatelessWidget {
  int score = 0;

  String scoreText;

  @override
  Widget build(BuildContext context) {
    //TODO: sätt text till den som matchar mängden poäng!
    ResultModel result = context.watch<ResultModel>();
    scoreText = result.text;
    score = result.score;
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Score: $score',
              textAlign: TextAlign.center,
              style: theme.textTheme.headline4),
          SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('$scoreText',
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
