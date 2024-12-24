import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/data/personal.dart';
import 'package:sidharth/src/common/extensions/build_context.dart';
import 'package:sidharth/src/common/widgets/scrollable/notifiable_list_view_builder.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class NameAndDesignation extends StatelessWidget {
  const NameAndDesignation({required this.metrics, super.key});

  final FreezedMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final fontSize = context.screenWidth * 0.05;
    final designationFontSize = context.screenWidth * 0.03;
    return IgnorePointer(
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, _dy(1.6)),
            child: Opacity(
              opacity: _opacity(50),
              child: TextWidget(
                Personal.name,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontFamily: FontFamily.cindieMonoD,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, _dy(1.3)),
            child: Opacity(
              opacity: _opacity(100),
              child: TextWidget(
                Personal.designation,
                style: TextStyle(
                  fontSize: designationFontSize,
                  color: Colors.white,
                  fontFamily: FontFamily.cindieMonoD,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, _dy(1.1)),
            child: Opacity(
              opacity: _opacity(150),
              child: TextWidget(
                Personal.year,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontFamily: FontFamily.cindieMonoD,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _dy(double speed) =>
      (metrics.scrollOffset - (metrics.scrollOffset * speed));
  double _opacity(speed) {
    return ((100 + speed) - metrics.scrollOffset).clamp(0, 100) / 100;
  }
}
