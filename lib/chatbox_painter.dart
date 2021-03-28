import 'package:chatty_widget/chatty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBoxBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  final BoxLocation boxLocation;
  final double tailSize;

  const ChatBoxBorderPainter({
    required this.boxLocation,
    required this.tailSize,
    this.strokeWidth = 2.0,
    this.strokeColor = const Color(0xFF000000),
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = strokeColor;

    canvas.drawPath(_getPath(size.width, size.height), paint);
  }

  Path _getPath(double x, double y) {
    final height = tailSize;
    final width = tailSize;
    Path path = Path();
    if (boxLocation == BoxLocation.Top) {
      return path
        ..moveTo(0.0, 0.0)
        ..lineTo(0, y - height)
        ..lineTo((x - width) / 2, y - height)
        ..lineTo(x / 2, y)
        ..lineTo((x + width) / 2, y - height)
        ..lineTo(x, y - height)
        ..lineTo(x, 0)
        ..lineTo(0, 0)
        ..close();
    } else {
      return path
        ..moveTo(x, y)
        ..lineTo(x, height)
        ..lineTo((x + width) / 2, height)
        ..lineTo(x / 2, 0)
        ..lineTo((x - width) / 2, height)
        ..lineTo(0, height)
        ..lineTo(0, y)
        ..lineTo(x, y)
        ..close();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
