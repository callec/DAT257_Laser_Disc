import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hast_app/screen/responsive_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hast_app/colors.dart';

/// The footer that is visible on all pages other than the home page
class HastFooter extends StatelessWidget {
  static const _link = 'https://www.hastutveckling.se';
  final _linkText = 'www.hastutveckling.se';
  final _fontName = 'Roboto';
  final _bgColor = footerBackground;
  final _fgColor = footerForeground;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, _getTopPadding(context), 0, 8),
          width: double.infinity,
          height: _getHeight(context),
          color: _bgColor,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: _fgColor, letterSpacing: 1.5, height: 1.5),
              children: <TextSpan>[
                TextSpan(text: _getText(context)),
                TextSpan(
                  text: '\n${_linkText}',
                  style: GoogleFonts.getFont(_fontName, textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () { launch(_link); }
                )
              ]
            ),
          ),
        ),
    );
  }
}

double _getTopPadding(BuildContext _context) {
  if (ResponsivePage.isLargeScreen(_context)) {
    return 14.0;
  } else if (ResponsivePage.isMediumScreen(_context)) {
    return 12.0;
  } else {
    return 8.0;
  }
}

double _getHeight(BuildContext _context) {
  if (ResponsivePage.isLargeScreen(_context)) {
    return 75.0;
  } else if (ResponsivePage.isMediumScreen(_context)) {
    return 90.0;
  } else {
    return 100.0;
  }
}

String _getText(BuildContext _context) {
  if (ResponsivePage.isLargeScreen(_context)) {
    return 'HAST Utveckling AB * Mässans gata 10, Göteborg/Sweden * +46 31 56 25 20';
  } else if (ResponsivePage.isMediumScreen(_context)) {
    return 'HAST Utveckling AB * Mässans gata 10, Göteborg/Sweden\n+46 31 56 25 20';
  } else {
    return 'HAST Utveckling AB\nMässans gata 10, Göteborg/Sweden\n+46 31 56 25 20';
  }
}
