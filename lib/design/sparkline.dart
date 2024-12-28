import 'dart:math';

import 'package:flutter/material.dart';

class Sparkline extends StatelessWidget {
  final List<double> data;
  final Color lineColor;
  final double lineWidth;
  final Color? fillColor;

  Sparkline({
    required this.data,
    this.lineColor = Colors.blue,
    this.lineWidth = 1.0,
    this.fillColor
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SparklinePainter(data: data, lineColor: lineColor, lineWidth: lineWidth, fillColor: fillColor),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final double lineWidth;
  final Color? fillColor;
  _SparklinePainter({
    required this.data,
    required this.lineColor,
    required this.lineWidth,
    this.fillColor
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double width = size.width;
    final double height = size.height;

    final double minData = data.reduce(min);
    final double maxData = data.reduce(max);
    final double dataRange = maxData - minData;
    if(dataRange <= 0) return;

    final double xStep = width / (data.length - 1);
    List<Offset> points = [];
    for(int i = 0; i < data.length; i++) {
      final double x = i * xStep;
      final double y = height - ((data[i] - minData)/ dataRange) * height;
      points.add(Offset(x,y));
    }

    final path = Path()..moveTo(points[0].dx, points[0].dy);

    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      final controlPoint1X = p1.dx + xStep/2;
      final controlPoint1Y = p1.dy;
      final controlPoint2X = p2.dx - xStep/2;
      final controlPoint2Y = p2.dy;

      path.cubicTo(controlPoint1X, controlPoint1Y, controlPoint2X, controlPoint2Y, p2.dx, p2.dy);
    }

    if (fillColor != null) {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      final fillPaint = Paint()
        ..color = fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return data != oldDelegate.data || lineColor != oldDelegate.lineColor || lineWidth != oldDelegate.lineWidth || fillColor != oldDelegate.fillColor;
  }
}