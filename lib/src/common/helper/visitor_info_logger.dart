import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http show get, post;
import 'package:sidharth/src/common/model/visit_info/ip_info.dart';
import 'package:sidharth/src/common/model/visit_info/visitor_info.dart';

class VisitorInfoLogger {
  const VisitorInfoLogger();

  Future<void> logInfo() async {
    if (kDebugMode) return;
    final config = await _getConfig();
    final ipInfo = await _getUserLocation(config);
    return _log(config.url, VisitersInfo.create(ipInfo: ipInfo));
  }

  List<IpDetails Function(Object)> get _decoders => [
        IpDetails.fromIpInfo,
        IpDetails.fromIpWho,
        IpDetails.fromIpApi,
        IpDetails.fromGeojs,
      ];

  Future<IpDetails> _getUserLocation(_EnvConfig config) async {
    final ipInfos = List.generate(
      _decoders.length,
      (index) {
        return _IPDetailsFetchers(
          decoder: _decoders[index],
          url: config.ipInfoUrls[index],
        );
      },
    );
    final ipOnlyInfos = List.generate(
      config.ipOnlyUrls.length,
      (index) {
        return _IPDetailsFetchers(
          decoder: IpDetails.onlyIP,
          url: config.ipOnlyUrls[index].url,
          isPlainTextResponse: config.ipOnlyUrls[index].isPlainTextResponse,
        );
      },
    );

    final services = [...ipInfos, ...ipOnlyInfos];
    final timeOutDuration = const Duration(seconds: 5);
    try {
      IpDetails? error;
      for (var i = 1; i < services.length; i++) {
        final service = services[i];
        final response =
            await http.get(Uri.parse(service.url)).timeout(timeOutDuration);
        if (response.statusCode == 200) {
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
      }

      return error ?? IpDetails.error(error: 'Failed look ip details');
    } catch (e) {
      return IpDetails.error(error: e.toString());
    }
  }

  Future<void> _log(String url, VisitersInfo info) async {
    try {
      await http.post(Uri.parse(url), body: jsonEncode(info.toJson()));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<_EnvConfig> _getConfig() async {
    final config = await rootBundle.loadString('env.json', cache: false);
    return _EnvConfig.fromJson(jsonDecode(config));
  }
}

class _EnvConfig {
  const _EnvConfig({
    required this.url,
    required this.ipInfoUrls,
    required this.ipOnlyUrls,
  });

  factory _EnvConfig.fromJson(Map<String, dynamic> json) {
    return _EnvConfig(
      url: json['url'] as String,
      ipInfoUrls: List<String>.from(
        (json['ipInfoUrls'] as List)
            .map((e) => (e as String).replaceAll(' ', '')),
      ),
      ipOnlyUrls: List.from(
        (json['ipOnlyUrls'] as List).map((e) => _IpOnlyUrl.fromJson(e)),
      ),
    );
  }
  final String url;
  final List<String> ipInfoUrls;
  final List<_IpOnlyUrl> ipOnlyUrls;
}

class _IpOnlyUrl {
  const _IpOnlyUrl({
    required this.url,
    required this.isPlainTextResponse,
  });

  factory _IpOnlyUrl.fromJson(Map<String, dynamic> json) {
    return _IpOnlyUrl(
      url: json['url'],
      isPlainTextResponse: json['isPlainTextResponse'],
    );
  }
  final String url;
  final bool isPlainTextResponse;
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
