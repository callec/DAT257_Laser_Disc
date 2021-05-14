import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hast_app/colors.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/screen/undefined_page.dart';
import 'package:provider/provider.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:hast_app/models/quiz_factory.dart';


/// This is the first page that is displayed to the User.
/// We load the Quiz from the URL query parameters
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
    _tryLoadingFile(query);
  }

  /// Load the Quiz file from the query parameters
  /// If we fail loading the file, errors will be displayed
  void _tryLoadingFile(String fileName) async{
    try{
      quiz = await QuizFactory.createQuiz(fileName);
      setState(() {
        isQuizLoaded = true;
        errorOccurred = false;
      });
    }catch(err){
      setState(() {
        isQuizLoaded = false;
        errorOccurred = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    var quizModel = Provider.of<QuizModel>(context, listen: false);
    final theme = Theme.of(context);
    final String _infoHast = "HAST Utveckling offer services of consulting, training, "
        "seminars and coaching as experts in the areas of Leadership, Communication, "
        "Effectiveness and Team Development. The company was founded in 2001 and have since then "
        "created results for managers, leaders and their personnel in over 40% of Sweden’s 100 largest companies. "
        "They have travelled to do work in more than 15 countries and have had participants in our programs "
        "from more than 40 different nations worldwide. We at HAST Utveckling, provide the climate needed for "
        "individuals and groups to take a good look at and discover key principles, behaviors and unaware preconceptions "
        "that keep us as human beings from reaching our true potential. These discoveries lead to waking people up to what "
        "is really going on. From real insight you hardly need to tell people what to do. Instead, people have a natural tendency "
        "to automatically implement behavior changes creating a new level of sustainable results. Fascinating! These changes result in "
        "increased peace of mind, focus and productivity as well as better worklife balance and new possibilities of innovation."
        " We turn stress to calm, conflict to teamwork, limitations to new results and managers to true leaders. We asked some of "
        "our most cherished customers, such as The West Sweden Chamber of Commerce, Volvo Penta, ABB, RISE (Research Institutes of Sweden),"
        " Preem, The Swedish Transport Administration and others, to describe, in their own words, what comes to mind when they think of HAST."
        " Here are a few examples of their comments: “Great structures. Keep their promises. Clear processes and competent people.”"
        "“Your level of competence is high, like many others, but you serve them with warmth and humor in a way that makes you stand out "
        "from the crowd.” “HAST dares to “touch on” matters that are not always comfortable to take a look at and that other suppliers just let go of.”";

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
            // What will be displayed on each tab (Home, About test, About us)
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
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: SingleChildScrollView(child: Column(children: [ //InfoPage is now scrollable, and their text is "inkastad".
                        _presentText(context, _infoHast),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0))
                      ])))),
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
        child: SingleChildScrollView(child: Column(children: [Text(presentingText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6)]),));
  }

  /// Displays a welcoming text and a start button IF we managed to load a Quiz
  Widget _homePageHomePage(context, QuizModel quizModel) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 200),
        child: SingleChildScrollView(child: Column(children: [
          _presentText(
              context, 'WELCOME! this is a quiz about ${isQuizLoaded ? quiz.quizTitle : "LOADING..."}'),
          Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0)),
          _startButton(context, quizModel)
        ])));
  }

  /// The button used to start the Quiz
  /// Displays a grayed out button if the Quiz is currently loading
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
