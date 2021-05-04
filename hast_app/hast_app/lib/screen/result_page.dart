import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatelessWidget {
  int score = 0;

  String scoreText;

  @override
  Widget build(BuildContext context) {
    ResultModel result = context.watch<ResultModel>();
    List<QuestionContent> questions = result.quizModel.questions;

    for (var question in questions) {
      //här har vi allt vi behöver för översikten
      print(question.question);
      print((question.chosenSubAlternative + 1) +
          (question.chosenAlternative * 3));
    }

    scoreText = result.text;
    score = result.score;
    final theme = Theme.of(context);

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text('Your score: $score' + "/96",
              //The final score after a evaluation.
              textAlign: TextAlign.center,
              style: theme.textTheme.headline4),
          SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('$scoreText', //the corresponding text for the score
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline5)),
          SizedBox(height: 100),

          new Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 40,
                      //width: 100,
                      //alignment: Alignment.center,
                      child: Row(children: <Widget>[
                        Spacer(flex: 2,),
                        Expanded(child: Text(questions[index].question, textAlign: TextAlign.center,)
                        ),
                        Expanded(child: Text(((questions[index].chosenSubAlternative + 1) + (questions[index].chosenAlternative * 3)).toString() + "/12", textAlign: TextAlign.center)),
                        Spacer(flex: 2,)
                        ],
                      ),
                    );
                  })),

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
