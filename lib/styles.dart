/*
** ──────────────────────────────────────────────────
** ─██████████████─██████──██████─████████──████████─
** ─██░░░░░░░░░░██─██░░██──██░░██─██░░░░██──██░░░░██─
** ─██░░██████████─██░░██──██░░██─████░░██──██░░████─
** ─██░░██─────────██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██─────────██░░██──██░░██───████░░░░░░████───
** ─██░░██──██████─██░░██──██░░██─────██░░░░░░██─────
** ─██░░██──██░░██─██░░██──██░░██───████░░░░░░████───
** ─██░░██──██░░██─██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██████░░██─██░░██████░░██─████░░██──██░░████─
** ─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─
** ─██████████████─██████████████─████████──████████─
** ──────────────────────────────────────────────────
*/
import 'package:flutter/material.dart';

const double padding = 16.0;

const Color colorTextPrimary = Color.fromRGBO(0, 0, 0, 0.87);
const Color colorTextSecondary = Color.fromRGBO(0, 0, 0, 0.6);
const Color colorTextInverse = Color.fromRGBO(250, 250, 250, 1);

const Color colorSurface = Color(0xFFB2D7FF);

Widget buildCard({
  required Widget child,
  String title = "",
  double elevation = 1.0,
  EdgeInsetsGeometry margin = const EdgeInsets.all(padding),
  Color color = Colors.white,
  BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(16.0)),
  Color borderColor = Colors.transparent,
  double borderWidth = 1.0,
}) {
  Widget realChild;
  if (title != null && title.length > 0) {
    realChild = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: padding, left: padding),
          child: Text(title, style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,),
          ),
        ),

        child,
      ],
    );
  } else {
    realChild = child;
  }
  return Card(
    elevation: elevation,
    margin: margin,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(color: borderColor, width: borderWidth),
    ),
    child: realChild,
  );
}

Widget buildTile(BuildContext context, {
  required String title,
  String? subtitle = "",
  String? description = "",
  String? imagePath = "",
  double? imageWidth = 72,
  double? imageHeight = 72,
  Widget? accent,
  List<Widget>? numbers = const[],
}) {
  List<Widget> lines = [];
  lines.add(SizedBox(height: 0));
  lines.add(Text(title,
    style: TextStyle(fontSize: 18, color: colorTextPrimary),
  ),);
  if (subtitle != '') {
    lines.add(Text(
      subtitle!,
      style: TextStyle(fontSize: 15, color: colorTextSecondary),
    ),);
  }
  if (description != '') {
    lines.add(Text(
      description!,
      style: TextStyle(fontSize: 14, color: colorTextSecondary),
    ),);
  }

  List<Widget> childrenInFirst = [];
  if (imagePath != "") {
    childrenInFirst.add(
      Image.asset(
        imagePath!,
        width: imageWidth!,
        height: imageHeight!,
        fit: BoxFit.cover,
      ),
    );
    childrenInFirst.add(SizedBox(width: 16),);
  }
  childrenInFirst.add(
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines,
      ),
    ),
  );
  if (accent != null) {
    childrenInFirst.add(
      accent
    );
  }
  List<Widget> lastNumbers = [];
  numbers!.forEach((num) {
    lastNumbers.add(
      Expanded(
        child: Container(
          height: 24,
          child: num,
        ),
      ),
    );
  });

  List<Widget> children = [];
  children.add(
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childrenInFirst,
    ),
  );

  if (lastNumbers.length > 0) {
    children.add(SizedBox(height: 8));
    children.add(
      Row(
        children: lastNumbers,
      ),
    );
  }
  return Container(
    margin: EdgeInsets.only(top: 16, left: 16, right: 16),
    decoration: BoxDecoration(
      color: colorSurface,
      borderRadius: BorderRadius.circular(20.0), // 设置圆角半径
    ),
    padding: EdgeInsets.all(16.0),
    child: InkWell(
      child: Column(
        children: children,
      ),
      onTap: () {
        print('hello');
      },
    ),
  );
}