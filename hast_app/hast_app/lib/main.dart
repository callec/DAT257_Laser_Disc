import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hast_app/colors.dart';
import 'package:hast_app/models/quiz_model.dart';
import 'package:hast_app/models/result_model.dart';
import 'package:hast_app/routing/router.dart' as router;
import 'package:provider/provider.dart';

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
        child: MaterialApp(
          title: "Hast Self Reflection",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: hastGrey,
            accentColor: hastRed,
            backgroundColor: hastWhite,

            // Define the default font family.
            fontFamily: GoogleFonts.roboto().fontFamily, // previously georgia but not on google fonts

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.hind().fontFamily),
              headline3: TextStyle(fontSize: 20.0, fontFamily: GoogleFonts.hind().fontFamily),
              headline4: TextStyle(fontSize: 40.0, color: Colors.black, fontFamily: GoogleFonts.hind().fontFamily),
              headline6: TextStyle(fontSize: 20.0, fontFamily: GoogleFonts.hind().fontFamily),
              bodyText2: TextStyle(fontSize: 16.0, fontFamily: GoogleFonts.hind().fontFamily),
            ),
          ),
        onGenerateRoute: router.generateRoute,
        initialRoute: HomeRoute,
      )
    );
  }
}
