import 'package:flutter/material.dart';

class DrawerTest extends StatefulWidget {
  final String title;

  DrawerTest({Key key, this.title}) : super(key: key);

  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
  int _selectedDestination = 1;
  int _questionCount = 8;
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

  Widget _buildList(BuildContext context, TextTheme textTheme) {
    return ListView.builder(
        itemCount: _questionCount,
        padding: EdgeInsets.zero,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Question Overview',
                    style: textTheme.headline6,
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
            leading: Icon(_finishedQuestions[i - 1] ? Icons.done : Icons.label,
            color: _finishedQuestions[i-1] ? Colors.green : null,),
            title: Text('Item ' + i.toString()),
            selected: _selectedDestination == i,
            onTap: () => selectDestination(i),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Drawer(child: _buildList(context, textTheme)),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Center(
                child: Text(_selectedDestination.toString()),
              )),
        ),
      ],
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
