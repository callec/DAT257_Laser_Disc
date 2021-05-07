import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:provider/provider.dart';

/// Displays an overview of Questions in the Quiz
/// for easy navigation between them
class QuestionDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(children: [
      Consumer<QuizModel>(
        builder: (context, model, child) => Drawer(
            child: model.loading // Display loading text if model is not ready
                ? Text("Loading Questions...")
                : _buildQuestionDrawer(context, theme, model)),
      ),
      /*VerticalDivider(
        width: 1,
        thickness: 1,
      ),*/
    ]);
  }

  Widget _buildQuestionDrawer(
      BuildContext context, ThemeData theme, QuizModel model) {
    return ListView.builder(
        itemCount: model.numberOfQuestions + 1,
        padding: EdgeInsets.zero,
        itemBuilder: (context, i) {
          //Create the title
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

          // Create the Questions
          // i - 1 is used to combat the shift problem with the title
          return ListTile(
            leading: Icon(
              Icons.label,
              color: model.currentNumber == i - 1 //check if this is currently selected
                  ? theme.accentColor
                  : theme.primaryColor,
            ),
            title: Text('Question ' + i.toString(),
                style: TextStyle(
                    fontFamily: theme.textTheme.bodyText2!.fontFamily,
                    color: model.currentNumber == i - 1
                        ? theme.accentColor
                        : theme.primaryColor)),

            selected: model.currentNumber == i - 1,
            onTap: () => model.setQuestion(i - 1),
          );
        });
  }
}
