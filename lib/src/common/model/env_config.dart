import 'dart:convert' show jsonDecode;

import 'package:http/http.dart' as http show get;

class EnvConfig {
  const EnvConfig({
    required this.url,
    required this.ipInfoUrls,
    required this.ipOnlyUrls,
  });

  factory EnvConfig.fromJson(Map<String, dynamic> json) {
    return EnvConfig(
      url: json['url'] as String,
      ipInfoUrls: List<String>.from(
        (json['ipInfoUrls'] as List).map(
          (e) => (e as String).replaceAll(' ', ''),
        ),
      ),
      ipOnlyUrls: List.from(
        (json['ipOnlyUrls'] as List).map((e) => IpOnlyUrl.fromJson(e)),
      ),
    );
  }

  final String url;
  final List<String> ipInfoUrls;
  final List<IpOnlyUrl> ipOnlyUrls;

  static Future<EnvConfig> load() async {
    try {
      final response = await http.get(Uri.parse('env.json'));
      return EnvConfig.fromJson(jsonDecode(response.body));
    } catch (e) {
      return const EnvConfig(url: '', ipInfoUrls: [], ipOnlyUrls: []);
    }
  }
}

class IpOnlyUrl {
  const IpOnlyUrl({required this.url, required this.isPlainTextResponse});

  factory IpOnlyUrl.fromJson(Map<String, dynamic> json) {
    return IpOnlyUrl(
      url: json['url'],
      isPlainTextResponse: json['isPlainTextResponse'],
    );
  }
  final String url;
  final bool isPlainTextResponse;
}
