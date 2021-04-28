//Created by Erik and Sam
//Edited by Erik, Felix, Sam

import 'package:flutter/material.dart';


class hastLogga extends StatelessWidget{
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/hastlogga.png",
      fit: BoxFit.contain,
      height: 45,
    );
  }
}



//Edited by Louise, Erik, Sam

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: hastLogga(),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: TabBar(
              labelColor: Color.fromARGB(255, 138, 146, 151),
              indicatorColor: Color.fromARGB(255,255, 49, 34),
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
                        _button(context)
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

  Widget _button(context) {
    //
    return ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor)),
        onPressed: () {
          Navigator.pushNamed(context, '/quiz');
        },
        child: Text("Start Self Reflection"));
  }
}

