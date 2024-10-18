
import 'dart:math';

import 'package:flutter/material.dart';

import 'model/poco.dart';

class SoccerPitchPainter extends CustomPainter {

  static final Color COLOR_SOCCER_PITCH = Color(0xff03ae00);

  static final double WIDTH_LINE = 2;

  final Drill drill;

  final int elapsed;

  SoccerPitchPainter(this.drill, this.elapsed);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = WIDTH_LINE
      ..style = PaintingStyle.stroke;

    final pitchHeight = size.height;
    final pitchWidth = size.width;

    paint.style = PaintingStyle.fill;
    paint.color = COLOR_SOCCER_PITCH;
    canvas.drawRect(Rect.fromLTWH(0, 0, pitchWidth, pitchHeight), paint);

    paint.style = PaintingStyle.stroke;
    paint.color = Colors.white;
    // Standard soccer pitch dimensions (in meters)
    const standardLength = 105.0;
    const standardWidth = 68.0;

    // Scale factors
    final pitchScale = pitchHeight / standardLength;

    // Draw the pitch outline
    canvas.drawRect(Rect.fromLTWH(WIDTH_LINE / 2, WIDTH_LINE / 2, pitchWidth - WIDTH_LINE, pitchHeight - WIDTH_LINE), paint);

    // Draw the halfway line
    final halfwayLineY = (pitchHeight - WIDTH_LINE * 2) / 2 - WIDTH_LINE / 2;
    canvas.drawLine(Offset(0, halfwayLineY), Offset(pitchWidth, halfwayLineY), paint);

    // Draw the center circle
    final centerCircleRadius = 9.15 * pitchScale;
    canvas.drawCircle(Offset(pitchWidth / 2, halfwayLineY), centerCircleRadius, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(pitchWidth / 2, halfwayLineY), 3, paint);

    // Draw the penalty areas
    paint.style = PaintingStyle.stroke;
    final penaltyAreaHeight = 16.5 * pitchScale;
    final penaltyAreaWidth = 41.32 * pitchScale;
    canvas.drawRect(Rect.fromLTWH((pitchWidth - penaltyAreaWidth) / 2, 0, penaltyAreaWidth, penaltyAreaHeight), paint);
    canvas.drawRect(Rect.fromLTWH((pitchWidth - penaltyAreaWidth) / 2, pitchHeight - penaltyAreaHeight, penaltyAreaWidth, penaltyAreaHeight), paint);

    // Draw the goal areas
    final goalAreaHeight = 5.5 * pitchScale;
    final goalAreaWidth = 18.32 * pitchScale;
    canvas.drawRect(Rect.fromLTWH((pitchWidth - goalAreaWidth) / 2, 0, goalAreaWidth, goalAreaHeight), paint);
    canvas.drawRect(Rect.fromLTWH((pitchWidth - goalAreaWidth) / 2, pitchHeight - goalAreaHeight, goalAreaWidth, goalAreaHeight), paint);

    // Draw the penalty spots
    paint.style = PaintingStyle.fill;
    final penaltySpotRadius = 3.0;
    final penaltySpotY = 11 * pitchScale;
    canvas.drawCircle(Offset(pitchWidth / 2, penaltySpotY), penaltySpotRadius, paint);
    canvas.drawCircle(Offset(pitchWidth / 2, pitchHeight - penaltySpotY), penaltySpotRadius, paint);

    paint.style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: Offset(pitchWidth / 2, penaltySpotY), radius: centerCircleRadius), pi / 4.8, pi / 1.70, false, paint);
    canvas.drawArc(Rect.fromCircle(center: Offset(pitchWidth / 2, pitchHeight - penaltySpotY), radius: centerCircleRadius), pi * 1.20, pi / 1.70, false, paint);

    // Draw the goals
    final goalWidth = 7.32 * pitchScale;
    final goalDepth = 4.0;
    canvas.drawRect(Rect.fromLTWH((pitchWidth - goalWidth) / 2, 0, goalWidth, goalDepth), paint);
    canvas.drawRect(Rect.fromLTWH((pitchWidth - goalWidth) / 2, pitchHeight - goalDepth, goalWidth, goalDepth), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}