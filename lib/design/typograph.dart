
import 'package:flutter/cupertino.dart';

class Headline1 extends StatelessWidget {

  final String text;

  final int lines;

  final double width;

  final double lineHeight;

  Headline1({
    required this.text,
    this.lineHeight = 0,
    this.lines = 1,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? double.infinity : width,
      alignment: Alignment.centerLeft,
      child: Text(text,
        maxLines: lines,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Headline2 extends StatelessWidget {

  final String text;

  final int lines;

  final double width;

  final double lineHeight;

  Headline2({
    required this.text,
    this.lineHeight = 0,
    this.lines = 1,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? double.infinity : width,
      alignment: Alignment.centerLeft,
      child: Text(text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Headline3 extends StatelessWidget {

  final String text;

  final int lines;

  final double width;

  final double lineHeight;

  Headline3({
    required this.text,
    this.lineHeight = 0,
    this.lines = 1,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? double.infinity : width,
      alignment: Alignment.centerLeft,
      child: Text(text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Headline4 extends StatelessWidget {

  final String text;

  final int lines;

  final double width;

  final double lineHeight;

  Headline4({
    required this.text,
    this.lineHeight = 0,
    this.lines = 1,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? double.infinity : width,
      alignment: Alignment.centerLeft,
      child: Text(text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Headline5 extends StatelessWidget {

  final String text;

  final int lines;

  final double width;

  final double lineHeight;

  Headline5({
    required this.text,
    this.lineHeight = 0,
    this.lines = 1,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? double.infinity : width,
      alignment: Alignment.centerLeft,
      child: Text(text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}