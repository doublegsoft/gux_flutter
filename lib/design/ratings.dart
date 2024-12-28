
import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final double starSize;
  final Color starColor;
  final Color emptyStarColor;
  final Function(double)? onRatingChanged;

  StarRating({
    required this.rating,
    this.starCount = 5,
    this.starSize = 36.0,
    this.starColor = Colors.amber,
    this.emptyStarColor = Colors.grey,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        double fillPercentage = rating - index;
        bool isSelected = fillPercentage > 0;

        return GestureDetector(
          onTap: () {
            if (onRatingChanged != null) {
              onRatingChanged!(index + 1.0);
            }
          },
          child: CustomPaint(
            size: Size(starSize, starSize),
            painter: StarPainter(
                fillPercentage: fillPercentage > 0 ? fillPercentage : 0,
                color: isSelected ? starColor : emptyStarColor),
          ),
        );
      }),
    );
  }
}

class StarPainter extends CustomPainter {
  final double fillPercentage;
  final Color color;

  StarPainter({
    required this.fillPercentage,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double outerRadius = size.width / 2;
    double innerRadius = outerRadius * 0.4; // Adjust for pointiness of star.

    // Calculate points for the star
    for (int i = 0; i < 5; i++) {
      double angle = (math.pi / 5) * i * 2 - (math.pi / 2);
      path.lineTo(
          centerX + outerRadius * math.cos(angle),
          centerY + outerRadius * math.sin(angle));

      angle = (math.pi / 5) * i * 2 + (math.pi / 5) - (math.pi / 2);
      path.lineTo(
        centerX + innerRadius * math.cos(angle),
        centerY + innerRadius * math.sin(angle),
      );
    }

    path.close();

    // Clip the path based on the filled percentage
    if (fillPercentage < 1) {
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width * fillPercentage, size.height));
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}