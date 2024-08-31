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