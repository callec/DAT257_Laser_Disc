import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';

//Created by Erik and Sam
//Edited by Louise, Erik, Sam

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var quizModel = context.watch<QuizModel>();

    return MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('HAST - self reflection'), //title on top of the page
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).accentColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Home', icon: Icon(Icons.home)), //Our tabs
                Tab(text: 'About the test', icon: Icon(Icons.help)),
                Tab(text: 'About us', icon: Icon(Icons.info)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _description(
                            context, 'WELCOME! Presenting Information'),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                        _button(context, quizModel)
                      ]))),
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _description(context, 'Answer honestly!!'),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
                      ]))),
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _description(context, 'Hast Info, good company'),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
                      ]))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _description(context, String presentingText) {
    //information text on home-page
    return Container(
        width: MediaQuery.of(context).size.width - 200,
        child: Text(presentingText,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 20.0, color: Colors.black)));
  }

  Widget _button(context, QuizModel quizModel) {
    //
    return ElevatedButton(
        onPressed: () {
          quizModel.reset();
          Navigator.pushNamed(context, '/drawer');
        },
        child: Text("Start Self Reflection"));
  }
}

class toTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Text("Här är första frågan."),
    );
  }
}
