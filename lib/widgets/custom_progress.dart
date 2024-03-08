import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medicine_alarm/constants.dart';

class CustomProgressWidget extends StatefulWidget {
  double progress;
  double strokeWidth;
  Color progressColor;

  CustomProgressWidget({
    Key? key,
    required this.progress,
    this.strokeWidth = 10.0,
    this.progressColor = Colors.blue,
  }) : super(key: key);

  @override
  _CustomProgressWidgetState createState() => _CustomProgressWidgetState();
}

class _CustomProgressWidgetState extends State<CustomProgressWidget>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
      painter: ProgressPainter(
        progress: widget.progress,
        strokeWidth: widget.strokeWidth,
        progressColor: widget.progressColor,
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;

  ProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
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
    var prog = (progress >= 99 ? 99 : progress);
    final double sweepAngle = 2 * pi * ((prog > 3 ? prog - 3 : 0.025) / 100);

    final progressPath = Path()
      ..addArc(
        Rect.fromCircle(center: center, radius: radius),
        pi / 24,
        sweepAngle,
      );

    canvas.drawPath(progressPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
