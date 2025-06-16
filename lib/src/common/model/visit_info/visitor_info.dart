import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sidharth/src/common/extensions/date_time.dart';
import 'package:sidharth/src/common/model/visit_info/browser_info.dart';
import 'package:sidharth/src/common/model/visit_info/ip_info.dart';

class VisitersInfo {
  VisitersInfo._({
    required this.ipInfo,
    required this.browserInfo,
    required this.utcTimeStamp,
  });

  factory VisitersInfo.create({
    required IpDetails ipInfo,
  }) {
    return VisitersInfo._(
      ipInfo: ipInfo,
      utcTimeStamp: DateTime.now().toUtc(),
      browserInfo: kIsWeb ? BrowserInfo.fromHtml() : null,
    );
  }

  final IpDetails ipInfo;
  final DateTime utcTimeStamp;
  final BrowserInfo? browserInfo;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'formatedTime': DateTime.now().formated(),
      'ipInfo': ipInfo.toJson(),
      'browserInfo': browserInfo?.toJson(),
      'utcTimeStamp': utcTimeStamp.millisecondsSinceEpoch,
    };
  }
}
