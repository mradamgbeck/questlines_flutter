// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String text;
  late final TextStyle? Function(BuildContext context)? getStyle;

  StyledText.appTitle(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
              displayLarge: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: const Color.fromARGB(255, 155, 210, 255),
                        blurRadius: 20)
                  ],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2))
          .displayLarge;
    };
  }

  StyledText.navButton(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
              headlineSmall: TextStyle(shadows: [
        Shadow(color: Color.fromARGB(255, 131, 205, 255), blurRadius: 25)
      ], color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2))
          .headlineSmall;
    };
  }

  StyledText.cardTitle(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
              titleSmall: TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 20)],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2))
          .titleSmall;
    };
  }

  StyledText.cardBody(this.text, {Key? key}) : super(key: key) {
    getStyle = (context) {
      return TextTheme(
              bodySmall: TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 20)],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2))
          .bodySmall;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getStyle?.call(context),
      softWrap: false,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
