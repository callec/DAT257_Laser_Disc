import 'package:flutter/material.dart';
import 'result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => MyHomePage(),
        '/result': (context) => ResultPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title = 'title';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                  return Colors.white;
                }),
                backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                  return Colors.blue;
                }),
              ),
              onPressed: () {Navigator.pushNamed(context, '/result');},
              child: Text('Result'),
            )));
  }
}
