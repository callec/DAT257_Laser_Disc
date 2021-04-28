import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  int score = 0;

  String scoreText;

  String text1 =
      'Perhaps you feel a little down or ‘feel’ like a failure. Life is hard, most things feel like it is a struggle. We know that from here it is difficult for you to get your head above water and see the possibilities for yourself and your life. In our signature programme, we create the conditions for our clients to operate from a place of strength, calm, clarity, creativity and resilience for both the short term and the long term, as we believe that without unleashing these and our other human capacities, hard work, or external productivity tools, no matter how sophisticated, will never be enough.';

  @override
  Widget build(BuildContext context) {
    //TODO: sätt text till den som matchar mängden poäng!
    scoreText = text1;
    /*switch(score){
      case (): {
        scoreText = text1;
      }
    }*/

    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text('Score: $score',
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 40.0, color: Colors.black)),
          SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text('$scoreText',
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 20.0, color: Colors.black))),
          SizedBox(height: 100),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return Color.fromARGB(255,255, 49, 34);
              }),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('Home'),
          )
        ])));
  }
}
