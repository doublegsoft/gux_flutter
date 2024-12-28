import 'dart:math' as math;
import 'package:flutter/material.dart';

class GXPulseLoader extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final int particleCount;

  const GXPulseLoader({
    Key? key,
    this.color = Colors.blue,
    this.size = 100.0,
    this.duration = const Duration(milliseconds: 1500),
    this.particleCount = 3,
  }) : super(key: key);

  @override
  State<GXPulseLoader> createState() => _GXPulseLoaderState();
}

class _GXPulseLoaderState extends State<GXPulseLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    // Create staggered animations for each particle
    _animations = List.generate(widget.particleCount, (index) {
      final delay = index * (widget.duration.inMilliseconds ~/ widget.particleCount);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            delay / widget.duration.inMilliseconds,
            (delay + widget.duration.inMilliseconds / 2) /
                widget.duration.inMilliseconds,
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating dots
          ...List.generate(widget.particleCount, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi +
                      (2 * math.pi / widget.particleCount) * index,
                  child: Transform.translate(
                    offset: Offset(widget.size * 0.25, 0),
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        width: widget.size * 0.15,
                        height: widget.size * 0.15,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          // Pulsing circles
          ...List.generate(widget.particleCount, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return CustomPaint(
                  painter: CirclePainter(
                    color: widget.color,
                    progress: _animations[index].value,
                  ),
                  size: Size(widget.size, widget.size),
                );
              },
            );
          }),
          // Center dot
          Container(
            width: widget.size * 0.2,
            height: widget.size * 0.2,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final double progress;

  CirclePainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity((1 - progress) * 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(
      size.center(Offset.zero),
      (size.width / 2) * progress,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

// Demo widget to show different loading animations
class LoadingDemo extends StatelessWidget {
  const LoadingDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Blue loader
            const GXPulseLoader(
              color: Colors.blue,
              size: 100,
              duration: Duration(milliseconds: 1500),
              particleCount: 3,
            ),
            // Purple gradient loader
            GXPulseLoader(
              color: Colors.purple.shade300,
              size: 80,
              duration: const Duration(milliseconds: 2000),
              particleCount: 4,
            ),
            // Green compact loader
            const GXPulseLoader(
              color: Colors.green,
              size: 60,
              duration: Duration(milliseconds: 1200),
              particleCount: 2,
            ),
          ],
        ),
      ),
    );
  }
}