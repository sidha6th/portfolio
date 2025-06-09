import 'package:flutter/material.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';
import 'package:url_launcher/url_launcher_string.dart' deferred as launch;

class LaunchableTextWidget extends StatefulWidget {
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
  State<LaunchableTextWidget> createState() => _LaunchableTextWidgetState();
}

class _LaunchableTextWidgetState extends State<LaunchableTextWidget> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: InkWell(
        mouseCursor: SystemMouseCursors.none,
        onTap: () {
          launch.loadLibrary().then(
            (value) {
              launch.launchUrlString(widget.url);
            },
          );
        },
        child: AnimatedScale(
          duration: Duration(milliseconds: hovering ? 400 : 200),
          curve: hovering ? Curves.elasticOut : Curves.easeInOut,
          scale: hovering ? 1.2 : 1,
          child: TextWidget(
            widget.text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: FontFamily.elgocThin,
              fontSize: (widget.width * 0.1).clamp(1, 54),
            ),
            softWrap: false,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
