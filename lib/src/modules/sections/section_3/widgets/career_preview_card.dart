import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/model/freezed_metrics.dart';

class CareerPreviewCard extends StatelessWidget {
  const CareerPreviewCard({
    required this.metrics,
    required this.child,
    required this.height,
    super.key,
  });

  final FreezeMetrics metrics;
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CornerBorderPainter(),
      isComplex: true,
      child: DottedBorder(
        color: AppColors.offWhite,
        dashPattern: [2, 3],
        child: SizedBox(
          width: (metrics.windowWidth * 0.3).clamp(200, 300),
          height: height,
          child: child,
        ),
      ),
    );
  }
}

class CornerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final topLeft = Path()
      ..moveTo(20, 0)
      ..lineTo(0, 0)
      ..lineTo(0, 20);

    final topRight = Path()
      ..moveTo(size.width - 20, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, 20);

    final bottomRight = Path()
      ..moveTo(size.width, size.height - 20)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - 20, size.height);

    final bottomLeft = Path()
      ..moveTo(0, size.height - 20)
      ..lineTo(0, size.height)
      ..lineTo(20, size.height);

    canvas.drawPath(topLeft, paint);
    canvas.drawPath(topRight, paint);
    canvas.drawPath(bottomRight, paint);
    canvas.drawPath(bottomLeft, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
