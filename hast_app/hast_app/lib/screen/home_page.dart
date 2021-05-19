import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hast_app/colors.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/models/quiz_factory.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/screen/home_page_data.dart';
import 'package:hast_app/screen/responsive_page.dart';
import 'package:hast_app/screen/undefined_page.dart';
import 'package:provider/provider.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

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

  // TODO formatting
  final String _infoHast = INFO_TEXT;
  final String _hastWelcome = HAST_WELCOME;
  final String _customerQuotes = HAST_QUOTES;


  _HomePageState(String query){
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
    var _quizModel = Provider.of<QuizModel>(context, listen: false);
    final _theme = Theme.of(context);
    double _padding = ResponsivePage.isMediumScreen(context) ? 30 : 100;

    // Here we display 3 tabs (home, about the test and about HAST)
    return MaterialApp(
      title: 'Hast Self Reflection',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: HastLogo(),
            automaticallyImplyLeading: false,
            backgroundColor: _theme.backgroundColor,
            bottom: TabBar(
              labelColor: _theme.primaryColor,
              indicatorColor: _theme.accentColor,
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
              errorOccurred ? UndefinedPage() : _homePageHomePage(context, _quizModel, _padding),
              isQuizLoaded ? _homePageAbout(_padding) : (errorOccurred ? UndefinedPage() : _presentText(context, "Loading...", TextAlign.center)),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, _padding/2 + 15, 0, _padding),
                    child: Column(
                      children: [ //InfoPage is now scrollable, and their text is "inkastad".
                        _presentText(context, _infoHast, TextAlign.justify),
                        _presentText(context, _customerQuotes, TextAlign.center),
                  ]))),
            ],
          ),
        ),
      ),
    );
  }

  /// Displays information text on the home_page in a nice formatted way
  Widget _presentText(context, String presentingText, TextAlign alignment) {
    return Container(
        // TODO doesn't work properly on iOS
        // for small devices: keep text to 80% of the width, otherwise 600px to
        // keep ~70 character at a time in a paragraph for readability.
        width: ResponsivePage.isMediumScreen(context) ? (MediaQuery.of(context).size.width*0.8) : 600,
        child: SingleChildScrollView(child: Column(children: [SimpleRichText(presentingText,
            textAlign: alignment,
            style: Theme.of(context).textTheme.headline6)]),));
  }

  /// Displays a welcoming text and a start button IF we managed to load a Quiz
  Widget _homePageHomePage(context, QuizModel quizModel, double _padding) {
    bool _size = ResponsivePage.isMediumScreen(context);

    return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, _padding/2 + 15, 0, _padding),
          child: Column(
            children: [
              _presentText(
                context,'${isQuizLoaded ? _hastWelcome : "LOADING..."}',
                TextAlign.justify
              ),
              SizedBox(height: _size ? 50 : 100,),
              _startButton(context, quizModel),
              Container(
                margin: EdgeInsets.fromLTRB(0, _padding, 0, 0),
              )
        ])));
  }

  /// Display information about the current Quiz.
  Widget _homePageAbout(double _padding) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.fromLTRB(0, _padding/2 + 15, 0, _padding),
            child: Column(children: [
              _presentText(context, quiz.quizInfo, TextAlign.justify),
            ])));
  }

  /// The button used to start the Quiz
  /// Displays a grayed out button if the Quiz is currently loading
  Widget _startButton(context, QuizModel quizModel) {
    if (isQuizLoaded){
      return ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  hastLightGreen)),
          onPressed: () {
            quizModel.loadQuiz(quiz);
            Navigator.pushNamed(context, QuizRoute);
          },
          child: Padding( padding: EdgeInsets.fromLTRB(8, 24 ,8,24),
              child: SimpleRichText(
                  "*Start the ${quiz.quizTitle} now!*",
                  textAlign: TextAlign.center,
                  //textScaleFactor: 1.3,
                  style: TextStyle(
                      fontSize: 18,
                      color: hastWhite,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.roboto().fontFamily)))
      );
    } else {
      return ElevatedButton(
          style: TextButton.styleFrom(
              backgroundColor: disabledGrey),
          onPressed: null,
          child: Text("LOADING..."));
    }
  }
}

/// Widget representing the HAST logo
class HastLogo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children:
        [
          Image.asset("assets/images/hastlogga.png",
                      fit: BoxFit.contain,
                      height: ResponsivePage.isMediumScreen(context) ? 35 : 40),
          SizedBox(width: 16),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Lifestyle & Work Assessment Tool",
                textAlign: TextAlign.center,
                style: TextStyle(color: hastGrey)),
          )
        ]
    );
  }
}
