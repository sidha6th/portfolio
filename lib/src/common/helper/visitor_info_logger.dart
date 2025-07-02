import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:http/http.dart' as http show get, post;
import 'package:sidharth/src/common/model/env_config.dart';
import 'package:sidharth/src/common/model/version_info.dart';
import 'package:sidharth/src/common/model/visit_info/ip_info.dart';
import 'package:sidharth/src/common/model/visit_info/visitor_info.dart';
import 'package:sidharth/src/core/mixins/logger_mixin.dart';

class VisitorInfoLogger with LoggerMixin {
  const VisitorInfoLogger._();

  static const instance = VisitorInfoLogger._();

  Future<void> logInfo() async {
    if (!kReleaseMode) return;
    final config = await EnvConfig.load();
    final versionInfo = await VersionInfo.load();
    final ipInfo = await _getUserLocation(config);
    return _log(
      config.url,
      VisitersInfo.create(ipInfo: ipInfo, version: versionInfo.version),
    );
  }

  List<IpDetails Function(Object)> get _decoders => [
    IpDetails.fromIpInfo,
    IpDetails.fromIpWho,
    IpDetails.fromIpApi,
    IpDetails.fromGeojs,
  ];

  Future<IpDetails> _getUserLocation(EnvConfig config) async {
    final ipInfos = List.generate(_decoders.length, (index) {
      return _IPDetailsFetchers(
        decoder: _decoders[index],
        url: config.ipInfoUrls[index],
      );
    });
    final ipOnlyInfos = List.generate(config.ipOnlyUrls.length, (index) {
      return _IPDetailsFetchers(
        decoder: IpDetails.onlyIP,
        url: config.ipOnlyUrls[index].url,
        isPlainTextResponse: config.ipOnlyUrls[index].isPlainTextResponse,
      );
    });

    final services = [...ipInfos, ...ipOnlyInfos];
    final timeOutDuration = const Duration(seconds: 10);
    IpDetails? error;
    for (var i = 0; i < services.length; i++) {
      try {
        final service = services[i];
        final response = await http
            .get(Uri.parse(service.url))
            .timeout(timeOutDuration);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return service.decoder(
            service.isPlainTextResponse
                ? response.body
                : jsonDecode(response.body),
          );
        }

        error = IpDetails.error(
          error:
              'Invalid response, status code ${response.statusCode}, data: ${response.body},',
        );
      } catch (e) {
        error = IpDetails.error(error: e.toString());
      }
    }
    return IpDetails.error(
      error:
          '${error?.error ?? ''} -\n All the ip details fetching service failed',
    );
  }

  Future<void> _log(String url, VisitersInfo info) async {
    log(info.values(), title: 'info details');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(info.values()),
      );
      log(response.body, title: 'Visit info Log response');
    } catch (e) {
      log(e, title: 'Visit info Log error response');
    }
  }
}

class _IPDetailsFetchers {
  const _IPDetailsFetchers({
    required this.url,
    required this.decoder,
    this.isPlainTextResponse = false,
  });

  final String url;
  final bool isPlainTextResponse;
  final IpDetails Function(Object) decoder;
}
