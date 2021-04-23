import 'package:flutter/material.dart';
import 'package:hast_app/question.dart';

//Created by Erik, Louise and Sam
//Edited by Sam, Louise and Erik

class DrawerTest extends StatefulWidget {
  final String title;

  DrawerTest({Key key, this.title}) : super(key: key);

  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
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
        Drawer(child: _buildOverviewDrawer(context, theme)),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Question(), //Nu en statisk fråga, kopplas senare 
        ),
      ],
    );
  }

  Widget _buildOverviewDrawer(BuildContext context, ThemeData theme) {
    return ListView.builder(
        itemCount: _finishedQuestions.length + 1,
        padding: EdgeInsets.zero,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Question Overview',
                    style: theme.textTheme.headline6
                  ),
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
              _finishedQuestions[i - 1] ? Icons.done : Icons.label,
              color: _selectedDestination == i
                  ? theme.accentColor
                  : _finishedQuestions[i - 1]
                  ? Colors.green
                  : null,
            ),
            title: Text('Question ' + i.toString()),
            selected: _selectedDestination == i,
            onTap: () => selectDestination(i),

          );
        });
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
