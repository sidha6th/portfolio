import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchableTextWidget extends StatelessWidget {
  const LaunchableTextWidget({
    required this.width,
    required this.text,
    required this.url,
    super.key,
  });

  final double width;
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () => launchUrlString(url),
      child: TextWidget(
        text,
        style: TextStyle(
          fontFamily: FontFamily.elgocThin,
          fontWeight: FontWeight.w900,
          fontSize: (width * 0.1).clamp(1, 54),
        ),
        softWrap: false,
        textAlign: TextAlign.center,
      ),
    );
  }
}
