import 'package:flutter/material.dart';

/// This class is used to identify the size of the screen.
/// Can be used to adjust the interface depending on screen-size.
class ResponsivePage {

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 800 && MediaQuery.of(context).size.width > 400;
  }

  static bool isSmallScreen(BuildContext context) {
    var _ratio = MediaQuery.of(context).size.aspectRatio < 9/16;
    return MediaQuery.of(context).size.width <= 400 || _ratio;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }
}

