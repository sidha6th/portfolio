import 'package:flutter/widgets.dart';
import 'package:sidharth/gen/fonts.gen.dart';
import 'package:sidharth/src/common/constants/colors.dart';
import 'package:sidharth/src/common/constants/constants.dart';
import 'package:sidharth/src/common/model/version_info.dart';
import 'package:sidharth/src/common/widgets/text/text_widget.dart';

class VersionIndicator extends StatefulWidget {
  const VersionIndicator({super.key});

  @override
  State<VersionIndicator> createState() => _VersionIndicatorState();
}

class _VersionIndicatorState extends State<VersionIndicator> {
  late final paint = Paint()
    ..blendMode = BlendMode.difference
    ..color = AppColors.offWhite
    ..strokeCap = StrokeCap.round;

  String? version;

  @override
  void initState() {
    VersionInfo.load().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() => version = value.version);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Misc.isMobile || version == null) return const SizedBox.shrink();
    return Positioned(
      bottom: 10,
      right: 10,
      child: TextWidget(
        'v: $version',
        style: TextStyle(
          fontSize: 4,
          foreground: paint,
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.cindieMonoD,
        ),
      ),
    );
  }
}
