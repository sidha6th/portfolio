import 'dart:convert' show jsonDecode;

import 'package:http/http.dart' as http show get;

class VersionInfo {
  const VersionInfo({
    required this.version,
    required this.appName,
    required this.packageName,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      version: json['version'],
      appName: json['app_name'],
      packageName: json['package_name'],
    );
  }

  final String version;
  final String appName;
  final String packageName;

  static Future<VersionInfo> load() async {
    final response = await http.get(Uri.parse('version.json'));
    if (response.statusCode == 200) {
      return VersionInfo.fromJson(jsonDecode(response.body));
    } else {
      return const VersionInfo(
        appName: 'sidharth',
        version: '0.0.1 temp',
        packageName: 'sidharth',
      );
    }
  }
}
