import 'package:flutter/material.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/screen/home_page.dart';
import 'package:hast_app/screen/quiz_page.dart';
import 'package:hast_app/screen/result_page.dart';
import 'package:hast_app/screen/undefined_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case QuizRoute:
      return MaterialPageRoute(builder: (context) => QuizPage());
    case ResultRoute:
      return MaterialPageRoute(builder: (context) => ResultPage());
    default:
      return MaterialPageRoute(builder: (context) => UndefinedPage());
  }
}