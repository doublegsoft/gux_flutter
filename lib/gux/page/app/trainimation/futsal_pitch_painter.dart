import 'dart:math';

import 'package:flutter/material.dart';

import 'model/poco.dart';

class FutsalPitchPainter extends CustomPainter {

  static final Color COLOR_FUTSAL_PITCH = Color(0xff229a43);

  static final double WIDTH_LINE = 2;

  final Drill drill;

  final int elapsed;

  FutsalPitchPainter(this.drill, this.elapsed);

  @override
  void paint(Canvas canvas, Size size) {
    print(elapsed);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = WIDTH_LINE
      ..style = PaintingStyle.stroke;

    final pitchHeight = size.height;
    final pitchWidth = size.width;

    paint.color = COLOR_FUTSAL_PITCH;
    canvas.drawRect(Rect.fromLTWH(0, 0, pitchWidth, pitchHeight), paint);

    paint.color = Colors.white;

    // Standard futsal pitch dimensions (in meters)
    const standardLength = 40.0;
    const standardWidth = 22.0;

    // Scale factors
    final pitchScale = pitchHeight / standardLength;

    // Draw the green background
    final backgroundPaint = Paint()..color = Colors.green;
    canvas.drawRect(Rect.fromLTWH(0, 0, pitchWidth, pitchHeight), backgroundPaint);

    // Draw the pitch outline
    canvas.drawRect(Rect.fromLTWH(WIDTH_LINE / 2, WIDTH_LINE / 2, pitchWidth - WIDTH_LINE, pitchHeight - WIDTH_LINE / 2), paint);

    // Draw the halfway line
    final halfwayLineY = pitchHeight / 2;
    canvas.drawLine(Offset(0, halfwayLineY), Offset(pitchWidth, halfwayLineY), paint);

    // Draw the center circle

    final centerCircleRadius = 3 * pitchScale;
    canvas.drawCircle(Offset(pitchWidth / 2, halfwayLineY), centerCircleRadius, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(pitchWidth / 2, halfwayLineY), 3, paint);

    // Draw the penalty areas
    paint.style = PaintingStyle.stroke;
    // Draw the penalty spots
    final goalWidth = 3 * pitchScale;
    final penaltySpotRadius = 3.0;
    double penaltySpotY = 6 * pitchScale;

    // Solid circle paint
    final solidCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(pitchWidth / 2, penaltySpotY), penaltySpotRadius, solidCirclePaint);
    canvas.drawCircle(Offset(pitchWidth / 2, pitchHeight - penaltySpotY), penaltySpotRadius, solidCirclePaint);
    canvas.drawLine(Offset((pitchWidth - goalWidth) / 2, penaltySpotY), Offset((pitchWidth + goalWidth) / 2, penaltySpotY), paint);
    canvas.drawLine(Offset((pitchWidth - goalWidth) / 2, pitchHeight - penaltySpotY), Offset((pitchWidth + goalWidth) / 2, pitchHeight - penaltySpotY), paint);

    penaltySpotY = 10 * pitchScale;
    canvas.drawCircle(Offset(pitchWidth / 2, penaltySpotY), penaltySpotRadius, solidCirclePaint);
    canvas.drawCircle(Offset(pitchWidth / 2, pitchHeight - penaltySpotY), penaltySpotRadius, solidCirclePaint);

    canvas.drawArc(Rect.fromCircle(center: Offset((pitchWidth - goalWidth) / 2, pitchHeight), radius: 6 * pitchScale), pi, pi / 2, false, paint);
    canvas.drawArc(Rect.fromCircle(center: Offset((pitchWidth + goalWidth) / 2, pitchHeight), radius: 6 * pitchScale), pi * 3 / 2, pi / 2, false, paint);

    canvas.drawArc(Rect.fromCircle(center: Offset((pitchWidth - goalWidth) / 2, 0), radius: 6 * pitchScale), pi / 2, pi / 2, false, paint);
    canvas.drawArc(Rect.fromCircle(center: Offset((pitchWidth + goalWidth) / 2, 0), radius: 6 * pitchScale), 0, pi / 2, false, paint);

    // Draw the goals
    final goalDepth = 4.0;
    canvas.drawRect(Rect.fromLTWH((pitchWidth - goalWidth) / 2, 0, goalWidth, goalDepth), paint);
    canvas.drawRect(Rect.fromLTWH((pitchWidth - goalWidth) / 2, pitchHeight - goalDepth, goalWidth, goalDepth), paint);

    ///
    /// DRILL
    ///
    _renderDrill(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _renderDrill(Canvas canvas) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    drill.equipments.forEach((el) {
      if (el.type == Equipment.player) {
        Player player = el as Player;
        paint.color = player.selected ? player.foreground : player.background;
        player.size = 15;
        canvas.drawCircle(player.position, player.size!, paint);
        _drawPlayerNumber(canvas, player);
        _drawPlayerRunning(canvas, player);
      }
    });
  }

  void _drawPlayerNumber(Canvas canvas, Player player) {
    double fontSize = 16;
    final textSpan = TextSpan(
      text: player.number.toString(),
      style: TextStyle(
        color: player.selected ? player.background : player.foreground,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
    double w = textPainter.width;

    final offset = Offset(player.position.dx - w / 2, player.position.dy - fontSize / 2 - 1);
    textPainter.paint(canvas, offset);
  }

  void _drawPlayerRunning(Canvas canvas, Player player) {
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    player.runnings.forEach((run) {
      Player dummy = player.clone();
      dummy.position = run.end;
      paint.color = player.background.withOpacity(0.5);
      canvas.drawCircle(dummy.position, dummy.size!, paint);
      _drawPlayerNumber(canvas, dummy);
    });
  }
}