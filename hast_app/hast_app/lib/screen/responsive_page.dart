import 'package:flutter/material.dart';

///This class is used to identify the size of the screen.
///Can be used to adjust the interface depending on screen-size.

class ResponsivePage extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsivePage({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 800 && MediaQuery.of(context).size.width > 400;
  }

  static bool isSmallScreen(BuildContext context) {
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
          return mediumScreen ?? largeScreen;
        else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}

