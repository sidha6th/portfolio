import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sidharth/src/common/extensions/date_time.dart';
import 'package:sidharth/src/common/model/visit_info/browser_info.dart';
import 'package:sidharth/src/common/model/visit_info/ip_info.dart';

class VisitersInfo {
  VisitersInfo._({
    required this.ipInfo,
    required this.version,
    required this.browserInfo,
    required this.utcTimeStamp,
  });

  factory VisitersInfo.create({
    required IpDetails ipInfo,
    required String version,
  }) {
    return VisitersInfo._(
      ipInfo: ipInfo,
      version: version,
      utcTimeStamp: DateTime.now().toUtc(),
      browserInfo: kIsWeb ? BrowserInfo.create() : null,
    );
  }

  final String version;
  final IpDetails ipInfo;
  final DateTime utcTimeStamp;
  final BrowserInfo? browserInfo;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'formatedTime': DateTime.now().formated(),
      'version': version,
      'ipInfo': ipInfo.toJson(),
      'browserInfo': browserInfo?.toJson(),
      'utcTimeStamp': utcTimeStamp.millisecondsSinceEpoch,
    };
  }
}
