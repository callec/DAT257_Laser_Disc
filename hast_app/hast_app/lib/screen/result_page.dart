import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/screen/home_page.dart';
import 'package:provider/provider.dart';

/// Displays the score from the Quiz and a conclusion text
class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultModel _result = context.watch<ResultModel>(); // Load Result model
    //list used to access score per question, question title and question number, for the overview.
    List<QuestionContent> questions = _result.quizModel.questions;
    final String _scoreText = _result.text;
    final int _score = _result.score;
    final theme = Theme.of(context);
    int questionNumber = 0;

    return WillPopScope(onWillPop: () => Future.value(false),
    child: Scaffold(
        appBar: AppBar(
          //title: Text(context.read<QuizModel>().title),
          title: HastLogo(),
          automaticallyImplyLeading: false,
          backgroundColor: theme.backgroundColor,
        ),
        body: Center( child:SingleChildScrollView(child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Text('Your score is: $_score' + '/' + '${questions.length * 12}', //The final score after a evaluation.
                textAlign: TextAlign.center,
                style: theme.textTheme.headline4),
          SizedBox(height: 30),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('$_scoreText',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline5)),
          SizedBox(height: 20),

          Container(child: //the overview
          Theme(
            data: Theme.of(context).copyWith(dividerColor: theme.accentColor),
            child:
            Padding( //to get the overview in the middle and proper adjust when the window size is changed.
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.12,
                  right: MediaQuery.of(context).size.width * 0.12),
              child:
              IgnorePointer(child: //wrapped in a IgnorePointer to remove clickable event.
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:
                  DataTable( columns: const <DataColumn>[
                    DataColumn(
                        label: Text('Question', style: TextStyle(fontStyle: FontStyle.italic))),
                    DataColumn(
                        label: Text('Text', style: TextStyle(fontStyle: FontStyle.italic))),
                    DataColumn(
                        label: Text('Score', style: TextStyle(fontStyle: FontStyle.italic))),
                  ],
                      rows:
                      questions.map(((element) => DataRow( // Loops through dataColumnText, each iteration assigning the value to element
                        //fills the dataTable with data from the list.
                        cells: <DataCell>[
                          DataCell(Text("      " + (++questionNumber).toString())),
                          DataCell(Text(element.question)),
                          DataCell(Text(((element.chosenSubAlternative + 1) + element.chosenAlternative * 3).toString() + "/12"))
                        ],
                      ))).toList())))
              ))),

          SizedBox(
            height: 20),

         SizedBox(//button wrapped in sizeBox to be able to change its size.
           width: 100, height: 40,
             child: TextButton(
               style: ButtonStyle(
                 foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return theme.backgroundColor;
                  }),
                 backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                    return theme.accentColor;
                  }),
                ),
               onPressed: () {
                 Navigator.pushNamed(context, HomeRoute);
                },
               child: Text('Home'),
              )),

              SizedBox(height: 20),
        ]))));
  }
}
