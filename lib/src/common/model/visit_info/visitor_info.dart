import 'package:sidharth/src/common/extensions/date_time_extension.dart';
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
      browserInfo: BrowserInfo.create(),
      utcTimeStamp: DateTime.now().toUtc(),
    );
  }

  final String version;
  final IpDetails ipInfo;
  final DateTime utcTimeStamp;
  final BrowserInfo browserInfo;

  List<String> values() {
    return [
      DateTime.now().formated(),
      version,
      ...ipInfo.values(),
      ...browserInfo.values(),
      utcTimeStamp.millisecondsSinceEpoch.toString(),
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'formatedTime': DateTime.now().formated(),
      'version': version,
      'ipInfo': ipInfo.toJson(),
      'browserInfo': browserInfo.toJson(),
      'utcTimeStamp': utcTimeStamp.millisecondsSinceEpoch,
    };
  }
}
