import 'package:flutter/material.dart';

class ResponsiveQuizPage extends StatelessWidget {
  final Widget largeScreen;
  final Widget? smallScreen;
  final Widget? miniScreen;

  const ResponsiveQuizPage({
    Key? key,
    required this.largeScreen,
    this.smallScreen,
    this.miniScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 800 && MediaQuery.of(context).size.width > 400;
  }

  static bool isMiniScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 400;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return largeScreen;
        } else if (constraints.maxWidth <= 800 &&
            constraints.maxWidth > 400)
          return smallScreen ?? largeScreen;
        else {
          return miniScreen ?? largeScreen;
        }
      },
    );
  }
}

