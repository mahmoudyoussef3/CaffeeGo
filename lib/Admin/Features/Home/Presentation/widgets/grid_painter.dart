import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    double thirdWidth = size.width / 2;
    double thirdHeight = size.height / 3.9;

    // الخطوط العمودية
    canvas.drawLine(
        Offset(thirdWidth, 0), Offset(thirdWidth, size.height), paint);

    // الخطوط الأفقية
    canvas.drawLine(
        Offset(0, thirdHeight), Offset(size.width, thirdHeight), paint);
    canvas.drawLine(
        Offset(0, 2 * thirdHeight), Offset(size.width, 2 * thirdHeight), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
