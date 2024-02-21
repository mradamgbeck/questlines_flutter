import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  late final TextStyle? Function(BuildContext context)? getStyle;

StyledText.appTitle(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
        displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)
      ).displayLarge;
    };
  }

  StyledText.navButton(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
        headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)
      ).headlineSmall;
    };
  }

StyledText.cardTitle(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
        titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)
      ).titleSmall;
    };
  }

  StyledText.cardBody(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
        bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)
      ).bodySmall;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: getStyle?.call(context));
  }
}