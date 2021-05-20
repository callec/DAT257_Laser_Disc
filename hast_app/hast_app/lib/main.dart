import 'package:flutter/material.dart';
import 'package:hast_app/colors.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:hast_app/routing/locator.dart';
import 'package:hast_app/routing/navigation_service.dart';
import 'package:hast_app/routing/router.dart' as router;
import 'package:hast_app/screen/home_page.dart';
import 'package:hast_app/screen/undefined_page.dart';
import 'package:provider/provider.dart';

import 'models/quiz_factory.dart';
import 'routing/route_names.dart';

/// Creates the application, defines theme, start Models
void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //Precache the background
    precacheImage(AssetImage('assets/images/quizPageImage.png'), context);

    //Precache the HAST logo
    precacheImage(AssetImage("assets/images/hastlogga.png"), context);


    //Creates the models and connects QuizModel to ResultModel
    return MultiProvider(
      providers: [
        Provider(create: (context) => ResultModel()),
        ChangeNotifierProxyProvider<ResultModel, QuizModel>(
          create: (context) => QuizModel(),
          update: (context, result, quiz){
            result.setModel(quiz!);
            return quiz;
          }
        )
      ],
        child: MaterialApp.router(
          title: "Hast Self Reflection",
          debugShowCheckedModeBanner: false,
          routerDelegate: ,


          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: hastGrey,
            accentColor: hastRed,
            backgroundColor: hastWhite,

            // Define the default font family.
            fontFamily: 'Georgia',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline4: TextStyle(fontSize: 40.0, color: Colors.black),
              headline6: TextStyle(fontSize: 20.0),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),

      )
    );
  }
}

class QuizRoutePath {

  late final String id;
  late final bool isUnknown;

  QuizRoutePath.home() : id = "", isUnknown = false;

  QuizRoutePath.details(this.id) : isUnknown = false;

  QuizRoutePath.unknown() : id = "", isUnknown = true;

  bool get isHomePage => id == "";

  bool get isDetailsPage => id != "";
}

class QuizRouterDelegate extends RouterDelegate<QuizRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<QuizRoutePath> {

  late final GlobalKey<NavigatorState> navigatorKey;

  QuizRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  String _currentFile = "";
  bool show404 = false;

  QuizRoutePath get currentConfiguration {
    if (show404){
      return QuizRoutePath.unknown();
    }

    return (_currentFile == "") ? QuizRoutePath.home() : QuizRoutePath.details(_currentFile);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey("HomePage"),
          child: HomePage(_currentFile)
        ),
        if (show404)
          MaterialPage(key: ValueKey("UnknownPage"), child: UndefinedPage())
        //TODO?
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _currentFile = "";
        show404 = false;
        notifyListeners();


        return true;
      }
    );
  }

  @override
  Future<void> setNewRoutePath(QuizRoutePath path) async {
    if (path.isUnknown) {
      _currentFile = "";
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {

    }
  }

}

