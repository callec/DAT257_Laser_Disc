
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => MainPage(),
        '/question': (context) => toTest(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Självutvärdering")),
        body: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                child: Column(children: [
                  _description(),
                  Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                  _button(context)
                ]))));
  }

  Widget _description() {
    return Text(
      'Hello! How are you?',
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
      style: TextStyle(fontWeight: FontWeight.normal),
      //textWidthBasis: TextWidthBasis(2),
    );
  }

  Widget _button(context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/question');
        },
        child: Text("Börja din självutvärdering"));
  }
}

class toTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Här är första frågan."),

    );
  }

}