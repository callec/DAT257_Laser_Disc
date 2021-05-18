import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Display a 404 error if no matching path can be found
class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('ERROR: 404 - quiz not found',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center));
  }
}
