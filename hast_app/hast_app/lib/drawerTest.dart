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
  

  Widget _buildList(BuildContext context){

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListView.builder(
      itemCount: _questionCount,
      padding: EdgeInsets.zero,
      itemBuilder: (context, i){

        if(i == 0){
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
          leading: Icon(Icons.label),
          title: Text('Item ' + i.toString()),
          selected: _selectedDestination == i,
          onTap: () => selectDestination(i),
        );
      }
    );


  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Drawer(
          child: _buildList(context)
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