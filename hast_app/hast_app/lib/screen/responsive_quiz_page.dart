import 'package:flutter/material.dart';

class ResponsiveQuizPage extends StatelessWidget {
  final Widget largeScreen;
  final Widget? smallScreen;

  const ResponsiveQuizPage({
    Key? key,
    required this.largeScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 800;
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
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}

