import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sidharth/gen/assets.gen.dart';

class MainImageWidget extends StatelessWidget {
  const MainImageWidget({
    required this.imageWidth,
    super.key,
  });

  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FadeInDown(
        from: 50,
        child: Image.asset(
          width: imageWidth,
          fit: BoxFit.cover,
          Assets.images.jpeg.image.path,
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }
}
