import 'package:flutter/material.dart';

//Created by Erik and Sam
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
            title: Text('HAST - self reflection'), //title on top of the page
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff5808e5),
            bottom: TabBar(
              indicatorColor: Colors.white,
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
                        _description(context),
                        Container(margin: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                        _button(context)
                      ]))),
              Center(child: Text('Answer honestly!')),
              Center(child: Text('Hast')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _description(context) { //information text on home-page
    return Container(
        width: MediaQuery.of(context).size.width - 200,
        child: Text('WELCOME! Presenting Information',
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 20.0, color: Colors.black)));
  }

  Widget _button(context) { //
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/question');
        },
        child: Text("Start Self Reflection"));
  }
}

class toTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Text("Här är första frågan."),
    );
  }
}
