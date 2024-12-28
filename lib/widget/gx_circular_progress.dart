import 'dart:math';
import 'package:flutter/material.dart';

class GXCircularProgress extends StatefulWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final bool showPercentage;
  final TextStyle? percentageTextStyle;
  final bool animate;
  final Duration animationDuration;
  final Widget? centerWidget;

  const GXCircularProgress({
    Key? key,
    required this.progress,
    this.size = 100,
    this.strokeWidth = 10,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.progressColor = Colors.blue,
    this.showPercentage = true,
    this.percentageTextStyle,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.centerWidget,
  })  : assert(progress >= 0 && progress <= 100),
        super(key: key);

  @override
  State<GXCircularProgress> createState() => _GXCircularProgressState();
}

class _GXCircularProgressState extends State<GXCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(GXCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

      if (widget.animate) {
        _controller.forward(from: 0);
      } else {
        _controller.value = 1.0;
      }
    }
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
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: CircularProgressPainter(
                  progress: _animation.value,
                  strokeWidth: widget.strokeWidth,
                  backgroundColor: widget.backgroundColor,
                  progressColor: widget.progressColor,
                ),
              ),
              if (widget.centerWidget != null)
                widget.centerWidget!
              else if (widget.showPercentage)
                Text(
                  '${_animation.value.toStringAsFixed(1)}%',
                  style: widget.percentageTextStyle ??
                      TextStyle(
                        fontSize: widget.size * 0.2,
                        fontWeight: FontWeight.bold,
                        color: widget.progressColor,
                      ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * pi * (progress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}