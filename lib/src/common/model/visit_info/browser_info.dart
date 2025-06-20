import 'package:sidharth/src/common/extensions/string_extension.dart';
import 'package:web/web.dart' as web show window, document;

class BrowserInfo {
  BrowserInfo({
    String? product,
    String? lang,
    String? agent,
    String? vendor,
    String? platform,
  }) : _pageInfo = _PageInfo.create(),
       _screenInfo = _ScreenInfo.create(),
       _perfomanceInfo = _PerformanceInfo.create(),
       _platform = platform,
       _product = product,
       _vendor = vendor,
       _agent = agent,
       _lang = lang;

  factory BrowserInfo.create() {
    final navigator = web.window.navigator;
    return BrowserInfo(
      vendor: navigator.vendor,
      lang: navigator.language,
      product: navigator.product,
      agent: navigator.userAgent,
      platform: navigator.platform,
    );
  }

  final String? _lang;
  final String? _agent;
  final String? _vendor;
  final String? _product;
  final String? _platform;
  final _PageInfo _pageInfo;
  final _ScreenInfo _screenInfo;
  final _PerformanceInfo _perfomanceInfo;

  List<String> values() {
    return [
      _lang ?? '',
      _agent ?? '',
      _vendor ?? '',
      _product ?? '',
      _platform ?? '',
      ..._pageInfo.values(),
      ..._screenInfo.values(),
      ..._perfomanceInfo.values(),
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (_lang.hasData) 'lang': _lang,
      if (_agent.hasData) 'agent': _agent,
      if (_vendor.hasData) 'vendor': _vendor,
      if (_product.hasData) 'product': _product,
      if (_platform.hasData) 'platform': _platform,
      'pageInfo': _pageInfo.toJson(),
      'screenInfo': _screenInfo.toJson(),
      'perfomanceInfo': _perfomanceInfo.toJson(),
    };
  }
}

class _ScreenInfo {
  _ScreenInfo({this.innerSize, this.outerSize, this.devicePixelRatio});

  factory _ScreenInfo.create() {
    final window = web.window;
    return _ScreenInfo(
      devicePixelRatio: window.devicePixelRatio,
      innerSize: '${window.innerWidth}/${window.innerHeight}',
      outerSize: '${window.screen.width}/${window.screen.height}',
    );
  }

  final String? innerSize;
  final String? outerSize;
  final num? devicePixelRatio;

  List<String> values() {
    return [
      innerSize ?? '',
      outerSize ?? '',
      (devicePixelRatio ?? '').toString(),
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (innerSize.hasData) 'windowSize': innerSize,
      if (outerSize.hasData) 'screenSize': outerSize,
      if (devicePixelRatio != null) 'devicePixelRatio': devicePixelRatio,
    };
  }
}

class _PerformanceInfo {
  factory _PerformanceInfo.create() {
    final performance = web.window.performance;
    final loadTime =
        performance.timing.loadEventEnd.toInt() -
        performance.timing.navigationStart.toInt();

    return _PerformanceInfo(loadTimeMS: loadTime);
  }
  _PerformanceInfo({required this.loadTimeMS});

  final int? loadTimeMS;
  List<String> values() {
    return [(loadTimeMS ?? '').toString()];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{if (loadTimeMS != null) 'loadTimeMS': loadTimeMS};
  }
}

class _PageInfo {
  _PageInfo({
    required this.path,
    required this.from,
    required this.referrer,
    required this.currentUrl,
  });

  factory _PageInfo.create() {
    return _PageInfo(
      referrer: web.document.referrer.hasData
          ? web.document.referrer
          : 'Unknown',
      path: web.window.location.pathname,
      currentUrl: web.window.location.href,
      from: web.window.location.pathname
          .split('/')
          .firstWhere(
            (element) => element.trim().isNotEmpty,
            orElse: () => 'Unknown',
          ),
    );
  }

  final String from;
  final String? path;
  final String referrer;
  final String currentUrl;

  List<String> values() {
    return [from, path ?? '', referrer, currentUrl];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (path.hasData) 'path': path,
      if (from.hasData) 'from': from,
      if (referrer.hasData) 'referrer': referrer,
      if (currentUrl.hasData) 'currentUrl': currentUrl,
    };
  }
}
