import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/colors.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/screen/undefined_page.dart';
import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:hast_app/models/quiz_factory.dart';


/// This is the first page that is displayed to the User
/// Here we can start the quiz or get information about the Quiz or HAST
class HomePage extends StatefulWidget {

  final String query;

  HomePage(this.query);

  @override
  _HomePageState createState() => _HomePageState(query);
}

class _HomePageState extends State<HomePage> {
  late QuizContent quiz;

  bool isQuizLoaded = false;
  bool errorOccurred = false;

  _HomePageState(String query){
    print("current query:" + query);
    tryLoadingFile(query);
  }

  void tryLoadingFile(String fileName) async{
    try{
      quiz = await QuizFactory.createQuiz(fileName);
      setState(() {
        isQuizLoaded = true;
        errorOccurred = false;
      });
      print("SUCCESS LOADING FILE...");
    }catch(err){
      print("FAIL LOADING FILE...");
      setState(() {
        isQuizLoaded = false;
        errorOccurred = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    var quizModel = Provider.of<QuizModel>(context, listen: false);

    //quizModel.loadQuiz(query);

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
                  child: errorOccurred ? UndefinedPage() : _homePageHomePage(context, quizModel)),
              Center(
                  child: isQuizLoaded ? Container(
                      margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
                      child: Column(children: [
                        _presentText(context, quiz.quizInfo),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
                      ])) : (errorOccurred ? UndefinedPage() : _presentText(context, "Loading..."))
              ),
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


  Widget _homePageHomePage(context, QuizModel quizModel) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
        child: Column(children: [
          _presentText(
              context, 'WELCOME! this is a quiz about ${isQuizLoaded ? quiz.quizTitle : "LOADING..."}'),
          Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0)),
          _startButton(context, quizModel)
        ]));
  }

  Widget _startButton(context, QuizModel quizModel) {
    if (isQuizLoaded){
      return ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor)),
          onPressed: () {
            quizModel.loadQuiz(quiz);
            Navigator.pushNamed(context, QuizRoute);
          },
          child: Text("Start Self Reflection"));
    } else {
      return ElevatedButton(
          style: TextButton.styleFrom(
              backgroundColor: disabledGrey),
          onPressed: null,
          child: Text("Start Self Reflection"));
    }
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
