import 'package:flutter/material.dart';

class DrawerTest extends StatefulWidget {
  final String title;

  DrawerTest({Key key, this.title}) : super(key: key);

  @override
  _DrawerTestState createState() => _DrawerTestState();
}

class _DrawerTestState extends State<DrawerTest> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
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
              ListTile(
                leading: Icon(Icons.label, color: Colors.green,),
                title: Text('Question 1'),
                selected: _selectedDestination == 0,
                onTap: () => selectDestination(0),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 2'),
                selected: _selectedDestination == 1,
                onTap: () => selectDestination(1),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 3'),
                selected: _selectedDestination == 2,
                onTap: () => selectDestination(2),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 4'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 5'),
                selected: _selectedDestination == 4,
                onTap: () => selectDestination(4),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 6'),
                selected: _selectedDestination == 5,
                onTap: () => selectDestination(5),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 7'),
                selected: _selectedDestination == 6,
                onTap: () => selectDestination(6),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Question 8'),
                selected: _selectedDestination == 7,
                onTap: () => selectDestination(7),
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(20),
              childAspectRatio: 3 / 2,
              children: [
                Image.asset('assets/nav-drawer-1.jpg'),
                Image.asset('assets/nav-drawer-2.jpg'),
                Image.asset('assets/nav-drawer-3.jpg'),
                Image.asset('assets/nav-drawer-4.jpg'),
              ],
            ),
          ),
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