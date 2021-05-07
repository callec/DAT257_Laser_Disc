import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';

/// This is the first page that is displayed to the User
/// Here we can start the quiz or get information about the Quiz or HAST
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var quizModel = context.watch<QuizModel>();

    final theme = Theme.of(context);

    // Here we display 3 tabs (home, about the test and about HAST)
    return MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: HastLogo(),
            automaticallyImplyLeading: false,
            backgroundColor: theme.backgroundColor,
            bottom: TabBar(
              labelColor: theme.primaryColor,
              indicatorColor: theme.accentColor,
              tabs: [
                Tab(text: 'Home', icon: Icon(Icons.home)), //Our tabs
                Tab(text: 'About the test', icon: Icon(Icons.help)),
                Tab(text: 'About us', icon: Icon(Icons.info)),
              ],
            ),
          ),
          body: TabBarView(
            // What will be displayed on each tab
            children: [
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _presentText(
                            context, 'WELCOME! Presenting Information'),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                        _startButton(context, quizModel)
                      ]))),
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _presentText(context, 'Answer honestly!!'),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
                      ]))),
              Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _presentText(context, 'Hast Info, good company'),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
                      ]))),
            ],
          ),
        ),
      ),
    );
  }

  /// Displays information text on the home_page in a nice formatted way
  Widget _presentText(context, String presentingText) {
    return Container(
        width: MediaQuery.of(context).size.width - 200,
        child: Text(presentingText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6));
  }

  Widget _startButton(context, QuizModel quizModel) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).accentColor)),
        onPressed: () {
          //quizModel.reset();
          if (quizModel.answered != 0) quizModel.reset();
          Navigator.pushNamed(context, '/quiz');
        },
        child: Text("Start Self Reflection"));
  }
}

/// Widget representing the HAST logo
class HastLogo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/hastlogga.png",
      fit: BoxFit.contain,
      height: 45,
    );
  }
}
