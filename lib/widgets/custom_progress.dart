import 'dart:math';
import 'package:flutter/material.dart';

class CustomProgressWidget extends StatelessWidget {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color incompleteColor;

  const CustomProgressWidget({
    super.key,
    required this.progress,
    this.strokeWidth = 10.0,
    this.progressColor = Colors.blue,
    this.incompleteColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProgressPainter(
        progress: progress,
        strokeWidth: strokeWidth,
        progressColor: progressColor,
        incompleteColor: incompleteColor,
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color incompleteColor;

  ProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.incompleteColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (strokeWidth / 2);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final incompletePaint = Paint()
      ..color = incompleteColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweepAngle = 2 * pi * ((progress >= 100 ? 100 : progress) / 100);

    final progressPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        pi/24,
        sweepAngle,
      );

    canvas.drawPath(progressPath, progressPaint);

    final incompletePath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2 + sweepAngle,
        2 * pi - sweepAngle,
      );

    canvas.drawPath(incompletePath, incompletePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
