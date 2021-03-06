import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Display a 404 error if no matching path can be found
class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 16, 0),
      child: Column(
        children: [
          FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                  'Whoops! Something broke,\ntry opening the link from HAST again...',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center)),
          SizedBox(height: 32),
          image404()
        ],
      ),
    );
  }

  Widget image404() {
    return SvgPicture.asset("assets/images/404.svg");
  }
}
