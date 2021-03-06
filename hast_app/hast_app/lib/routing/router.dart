import 'package:flutter/material.dart';
import 'package:hast_app/routing/route_names.dart';
import 'package:hast_app/routing/string_extensions.dart';
import 'package:hast_app/screen/home_page.dart';
import 'package:hast_app/screen/quiz_page.dart';
import 'package:hast_app/screen/result_page.dart';
import 'package:hast_app/screen/undefined_page.dart';

/// Custom routing class that is responsible for navigating the application
/// Delegates the URL query to the HomePage

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name!.getRoutingData;

  switch (routingData.route) {
    case HomeRoute:

      //Pick out query parameter
      var q = routingData['q'];

      if (q != null){
        return MaterialPageRoute(builder: (context) => HomePage(q));
      } else {
        return MaterialPageRoute(builder: (context) => HomePage(""));
      }

    case QuizRoute:
      return MaterialPageRoute(builder: (context) => QuizPage());

    case ResultRoute:
      return MaterialPageRoute(builder: (context) => ResultPage());

    default:
      return MaterialPageRoute(builder: (context) => UndefinedPage());
  }
}