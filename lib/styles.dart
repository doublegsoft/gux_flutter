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

late double _screenWidth;

late double _screenHeight;

void init(BuildContext context) {
  final size = MediaQuery.of(context).size;
  _screenHeight = size.height;
  _screenWidth = size.width;
}

Color get colorPrimary {
  return Color(0xff3f86ff);
}

Color get colorError {
  return Color(0xffd32f2f);
}

Color get colorSuccess {
  return Color(0xff57B25A);
}

Color get colorSuccessLight {
  return Color(0xffF1F9F1);
}

Color get colorWarning {
  return Color(0xffFF780A);
}

Color get colorWarningLight {
  return Color(0xffFFF4EB);
}

Color get colorInfo {
  return Color(0xff4791C2);
}

Color get colorInfoLight {
  return Color (0xffF0F6FA);
}

Color get colorDivider {
  return Color.fromRGBO(0, 0, 0, 0.4);
}

Color get colorSurface {
  return Color(0xFFB2D7FF);
}

Color get colorTextPrimary {
  return Color.fromRGBO(0, 0, 0, 0.87);
}

Color get colorTextSecondary {
  return Color.fromRGBO(0, 0, 0, 0.87);
}

Color get colorTextInverse {
  return Color.fromRGBO(250, 250, 250, 1);
}

Color get colorTextPlaceholder {
  return Color.fromRGBO(0, 0, 0, 0.4);
}

double get screenHeight {
  return _screenHeight;
}

double get screenWidth {
  return _screenWidth;
}

double width(context, int paddingCount, int count) {
  double width = MediaQuery.of(context).size.width;
  return (width - padding * paddingCount) / count;
}

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
  String? title,
  Widget? titleWidget,
  String? subtitle = "",
  Widget? subtitleWidget,
  String? description = "",
  Widget? descriptionWidget,
  String? imagePath = "",
  double? imageWidth = 72,
  double? imageHeight = 72,
  Widget? imageWidget,
  Widget? accent,
  List<Widget>? numbers = const[],
  GestureTapCallback? onTap,
}) {
  List<Widget> lines = [];
  lines.add(SizedBox(height: 0));
  if (title != null) {
    lines.add(Text(title,
      style: TextStyle(fontSize: 18, color: colorTextPrimary),
    ),);
  } else if (titleWidget != null) {
    lines.add(titleWidget!);
  }
  if (subtitle != '') {
    lines.add(Text(
      subtitle!,
      style: TextStyle(fontSize: 15, color: colorTextSecondary),
    ),);
  } else if (subtitleWidget != null) {
    lines.add(subtitleWidget!);
  }
  if (description != '') {
    lines.add(Text(
      description??'',
      style: TextStyle(fontSize: 14, color: colorTextSecondary),
    ),);
  } else if (descriptionWidget != null) {
    lines.add(descriptionWidget!);
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
  } else if (imageWidget != null) {
    childrenInFirst.add(imageWidget);
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
      onTap: onTap != null ? onTap : () {},
    ),
  );
}