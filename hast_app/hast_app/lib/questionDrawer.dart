import 'package:flutter/material.dart';
import 'package:hast_app/models/quiz_model.dart';

//import 'package:hast_app/question.dart';
import 'package:hast_app/screen/quiz_page.dart';
import 'package:provider/provider.dart';

//Created by Erik, Louise and Sam
//Edited by Sam, Louise and Erik

class QuestionDrawer extends StatefulWidget {
  final String title;

  QuestionDrawer({Key key, this.title}) : super(key: key);

  @override
  _QuestionDrawerState createState() => _QuestionDrawerState();
}

class _QuestionDrawerState extends State<QuestionDrawer> {
  int _selectedDestination = 1;
  final List<bool> _finishedQuestions = [
    true,
    true,
    false,
    false,
    true,
    true,
    true,
    false
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
        children: [
          Consumer<QuizModel>(
            builder: (context, model, child) =>
                Drawer(child: _buildOverviewDrawer(context, theme, model)),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
          ),
        ]
    );
  }

  Widget _buildOverviewDrawer(
      BuildContext context, ThemeData theme, QuizModel model) {
    return ListView.builder(
        itemCount: _finishedQuestions.length + 1,
        padding: EdgeInsets.zero,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Question Overview',
                      style: theme.textTheme.headline6),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
              ],
            );
          }
          return ListTile(
            leading: Icon(
              Icons.label,
            ),
            title: Text('Question ' + i.toString()),
            selected: model.currentNumber == i - 1,
            onTap: () => model.setQuestion(i - 1),
          );
        });
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
