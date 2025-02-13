/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/jpeg
  $AssetsImagesJpegGen get jpeg => const $AssetsImagesJpegGen();

  /// Directory path: assets/images/png
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();

  /// Directory path: assets/images/svg
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsImagesJpegGen {
  const $AssetsImagesJpegGen();

  /// File path: assets/images/jpeg/image.jpeg
  AssetGenImage get image =>
      const AssetGenImage('assets/images/jpeg/image.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [image];
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/css.png
  AssetGenImage get css => const AssetGenImage('assets/images/png/css.png');

  /// File path: assets/images/png/dart.png
  AssetGenImage get dart => const AssetGenImage('assets/images/png/dart.png');

  /// File path: assets/images/png/flutter.png
  AssetGenImage get flutter =>
      const AssetGenImage('assets/images/png/flutter.png');

  /// File path: assets/images/png/git.png
  AssetGenImage get git => const AssetGenImage('assets/images/png/git.png');

  /// File path: assets/images/png/html.png
  AssetGenImage get html => const AssetGenImage('assets/images/png/html.png');

  /// File path: assets/images/png/image.png
  AssetGenImage get image => const AssetGenImage('assets/images/png/image.png');

  /// File path: assets/images/png/jetpack compose.png
  AssetGenImage get jetpackCompose =>
      const AssetGenImage('assets/images/png/jetpack compose.png');

  /// File path: assets/images/png/js.png
  AssetGenImage get js => const AssetGenImage('assets/images/png/js.png');

  /// File path: assets/images/png/kotlin.png
  AssetGenImage get kotlin =>
      const AssetGenImage('assets/images/png/kotlin.png');

  /// File path: assets/images/png/nodejs.png
  AssetGenImage get nodejs =>
      const AssetGenImage('assets/images/png/nodejs.png');

  /// File path: assets/images/png/react.png
  AssetGenImage get react => const AssetGenImage('assets/images/png/react.png');

  /// File path: assets/images/png/scss.png
  AssetGenImage get scss => const AssetGenImage('assets/images/png/scss.png');

  /// File path: assets/images/png/swift.png
  AssetGenImage get swift => const AssetGenImage('assets/images/png/swift.png');

  /// File path: assets/images/png/ts.png
  AssetGenImage get ts => const AssetGenImage('assets/images/png/ts.png');

  /// File path: assets/images/png/unity.png
  AssetGenImage get unity => const AssetGenImage('assets/images/png/unity.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        css,
        dart,
        flutter,
        git,
        html,
        image,
        jetpackCompose,
        js,
        kotlin,
        nodejs,
        react,
        scss,
        swift,
        ts,
        unity
      ];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/flutter.svg
  String get flutter => 'assets/images/svg/flutter.svg';

  /// List of all assets
  List<String> get values => [flutter];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
