import 'dart:math';

import 'package:flutter/material.dart';

class Sparkbar extends StatelessWidget {
  final List<double> data;
  final List<Color>? barColors;
  final double barWidth;
  final double borderRadius;
  Sparkbar({
    required this.data,
    this.barColors,
    this.barWidth = 5.0,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SparkBarPainter(
          data: data,
          barColors: barColors,
          barWidth: barWidth,
          borderRadius: borderRadius
      ),
    );
  }
}

class _SparkBarPainter extends CustomPainter {
  final List<double> data;
  final List<Color>? barColors;
  final double barWidth;
  final double borderRadius;
  _SparkBarPainter({
    required this.data,
    this.barColors,
    required this.barWidth,
    required this.borderRadius
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return; // Avoid drawing with no data

    final double width = size.width;
    final double height = size.height;
    final double maxData = data.reduce(max);
    final double barSpacing = (width - (data.length * barWidth)) / (data.length + 1); // Calculate spacing
    for (int i = 0; i < data.length; i++) {
      final double barHeight = (data[i] / maxData) * height;
      final double x = barSpacing + (barWidth + barSpacing) * i;
      final double y = height - barHeight; // Top of bar
      final paint = Paint()
        ..color = (barColors?.length ?? 0) > i ? barColors![i] : Colors.blue
        ..style = PaintingStyle.fill;
      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        Radius.circular(borderRadius),
      );

      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparkBarPainter oldDelegate) {
    return data != oldDelegate.data ||
        barColors != oldDelegate.barColors ||
        barWidth != oldDelegate.barWidth ||
        borderRadius != oldDelegate.borderRadius;
  }
}