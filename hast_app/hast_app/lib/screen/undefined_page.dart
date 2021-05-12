
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('ERROR: 404 - quiz not found', style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center)),);
  }



}