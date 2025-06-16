import 'dart:html' as html show window, document;

import 'package:sidharth/src/common/extensions/string_extension.dart';

class BrowserInfo {
  BrowserInfo({
    required this.pageInfo,
    required this.screenInfo,
    required this.perfomanceInfo,
    this.product,
    this.lang,
    this.agent,
    this.vendor,
    this.platform,
  });

  factory BrowserInfo.fromHtml() {
    final navigator = html.window.navigator;

    return BrowserInfo(
      vendor: navigator.vendor,
      lang: navigator.language,
      product: navigator.product,
      agent: navigator.userAgent,
      platform: navigator.platform,
      pageInfo: PageInfo.fromHtml(),
      screenInfo: ScreenInfo.fromHtml(),
      perfomanceInfo: PerformanceInfo.fromHtml(),
    );
  }

  final String? lang;
  final String? product;
  final String? agent;
  final String? vendor;
  final String? platform;
  final PageInfo pageInfo;
  final ScreenInfo screenInfo;
  final PerformanceInfo perfomanceInfo;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (lang.hasData) 'lang': lang,
      if (agent.hasData) 'agent': agent,
      if (vendor.hasData) 'vendor': vendor,
      if (platform.hasData) 'platform': platform,
      'pageInfo': pageInfo.toJson(),
      'screenInfo': screenInfo.toJson(),
      'perfomanceInfo': perfomanceInfo.toJson(),
    };
  }
}

class ScreenInfo {
  ScreenInfo({
    this.innerSize,
    this.outerSize,
    this.devicePixelRatio,
  });

  factory ScreenInfo.fromHtml() {
    final window = html.window;
    return ScreenInfo(
      devicePixelRatio: window.devicePixelRatio,
      innerSize: '${window.innerWidth}/${window.innerHeight}',
      outerSize: '${window.screen?.width}/${window.screen?.height}',
    );
  }

  final String? innerSize;
  final String? outerSize;
  final num? devicePixelRatio;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (innerSize.hasData) 'windowSize': innerSize,
      if (outerSize.hasData) 'screenSize': outerSize,
      if (devicePixelRatio != null) 'devicePixelRatio': devicePixelRatio,
    };
  }
}

class PerformanceInfo {
  factory PerformanceInfo.fromHtml() {
    final performance = html.window.performance;
    final loadTime = performance.timing.loadEventEnd.toInt() -
        performance.timing.navigationStart.toInt();

    return PerformanceInfo(
      loadTimeMS: loadTime,
    );
  }
  PerformanceInfo({
    required this.loadTimeMS,
  });

  final int? loadTimeMS;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (loadTimeMS != null) 'loadTimeMS': loadTimeMS,
    };
  }
}

class PageInfo {
  PageInfo({
    required this.path,
    required this.from,
    required this.referrer,
    required this.currentUrl,
  });

  factory PageInfo.fromHtml() {
    return PageInfo(
      referrer: html.document.referrer,
      path: html.window.location.pathname,
      currentUrl: html.window.location.href,
      from: html.window.location.pathname?.split('/').firstWhere(
                (element) => element.trim().isNotEmpty,
                orElse: () => '',
              ) ??
          '',
    );
  }

  final String from;
  final String? path;
  final String referrer;
  final String currentUrl;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (path.hasData) 'path': path,
      if (from.hasData) 'from': from,
      if (referrer.hasData) 'referrer': referrer,
      if (currentUrl.hasData) 'currentUrl': currentUrl,
    };
  }
}
