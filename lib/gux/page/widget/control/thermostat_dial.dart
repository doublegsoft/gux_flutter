import 'dart:math' as math;
import 'package:flutter/material.dart';

class ThermostatDial extends StatefulWidget {
  const ThermostatDial({Key? key}) : super(key: key);

  @override
  State<ThermostatDial> createState() => _ThermostatDialState();
}

class _ThermostatDialState extends State<ThermostatDial> {
  double _currentTemperature = 22;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Dial
            CustomPaint(
              painter: DialTicksPainter(
                tickCount: 100, // Adjust the number of ticks
                tickColor: Colors.grey[300]!,
                radius: 125,
              ),
            ),
            // Temperature Arc
            Transform.rotate(
              angle: (_currentTemperature - 10) / 10 * math.pi, // Adjust rotation based on temperature range (10-30 in this example).
              child: CustomPaint(
                painter: TemperatureArcPainter(
                  temperature: _currentTemperature,
                  arcColor: Colors.blue[300]!,
                  radius: 110,
                ),
              ),
            ),
            // Inner Circle
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HEATING',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${_currentTemperature.toInt()}', // Use toInt() or toStringAsFixed(1) for decimals
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.eco_outlined, color: Colors.green,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class DialTicksPainter extends CustomPainter {
  final int tickCount;
  final Color tickColor;
  final double radius;

  DialTicksPainter({
    required this.tickCount,
    required this.tickColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = tickColor
      ..strokeWidth = 2;

    for (int i = 0; i < tickCount; i++) {
      final angle = i * 2 * math.pi / tickCount;
      final x1 = center.dx + radius * math.cos(angle);
      final y1 = center.dy + radius * math.sin(angle);
      final x2 = center.dx + (radius - (i % 5 == 0 ? 10 : 5)) * math.cos(angle); // Longer ticks every 5
      final y2 = center.dy + (radius - (i % 5 == 0 ? 10 : 5)) * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }


  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TemperatureArcPainter extends CustomPainter {
  final double temperature;
  final Color arcColor;
  final double radius;


  TemperatureArcPainter({
    required this.temperature,
    required this.arcColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );
    final paint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;


    canvas.drawArc(
      rect,
      -math.pi / 2,  // Start angle (at the top)
      temperature / 10 * math.pi ,  // Sweep angle (adjust for your temperature range)
      false,
      paint,
    );

  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when temperature changes
  }
}