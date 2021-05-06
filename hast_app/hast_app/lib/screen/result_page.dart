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


    scoreText = result.text;
    score = result.score;
    final theme = Theme.of(context);

    return Scaffold(

        appBar: AppBar(
          //title: Text(context.read<QuizModel>().title),
          title: HastLogga(),
          automaticallyImplyLeading: false,
          backgroundColor: theme.backgroundColor,
        ),

        body: Center(

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
          Text('Your score is: $score' + "/96",
              //The final score after a evaluation.
              textAlign: TextAlign.center,
              style: theme.textTheme.headline4),
          SizedBox(height: 30),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('$scoreText', //the corresponding text for the score
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline5)),
          SizedBox(height: 20),


          new Expanded(
              child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: theme.accentColor
                  ),
                      child: Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.12, right: MediaQuery.of(context).size.width * 0.12),
                        child: ListView(
                            children: <Widget>[
                              IgnorePointer(child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,

                                  child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(

                                        label: Text(
                                          'Question',
                                          style: TextStyle(fontStyle: FontStyle.italic),

                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Text',
                                          style: TextStyle(fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Score',
                                          style: TextStyle(fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                    rows:
                                    questions // Loops through dataColumnText, each iteration assigning the value to element
                                        .map(

                                      ((element) => DataRow(

                                        cells: <DataCell>[

                                          DataCell(Text("      "+element.number.toString(),)),
                                          DataCell(Text(element.question)),
                                          DataCell(Text(((element.chosenSubAlternative+1)+element.chosenAlternative*3).toString()+"/12")),
                                          //Extracting from Map element the value

                                        ],
                                      )),
                                    )
                                        .toList(),
                                  )))

                            ]
                        ),
                      )
                        ,
                    )),

          SizedBox(height: 20,),

          SizedBox(
            width: 100,
            height: 40,
            child: TextButton(
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
          ),
                  SizedBox(height: 20),
        ])));

  }
}
class HastLogga extends StatelessWidget{
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/hastlogga.png",
      fit: BoxFit.contain,
      height: 45,

    );
  }
}