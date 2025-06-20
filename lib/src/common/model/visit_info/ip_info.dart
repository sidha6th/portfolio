class IpDetails {
  IpDetails({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.loc,
    required this.org,
    required this.postal,
    required this.timezone,
    this.error,
  });

  IpDetails.error({this.error})
    : ip = null,
      city = null,
      region = null,
      country = null,
      loc = null,
      org = null,
      postal = null,
      timezone = null;

  factory IpDetails.fromIpInfo(Object json) {
    json = json as Map<String, dynamic>;
    return IpDetails(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      loc: json['loc'],
      org: json['org'],
      postal: json['postal'],
      timezone: json['timezone'],
    );
  }

  factory IpDetails.fromGeojs(Object json) {
    json = json as Map<String, dynamic>;
    return IpDetails(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      loc: '${json['latitude']},${json['longitude']}',
      org: json['organization'],
      postal: null,
      timezone: json['timezone'],
    );
  }

  factory IpDetails.fromIpApi(Object json) {
    json = json as Map<String, dynamic>;
    return IpDetails(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country_name'],
      loc: '${json['latitude']},${json['longitude']}',
      org: json['org'],
      postal: json['postal'],
      timezone: json['timezone'],
    );
  }

  factory IpDetails.fromIpWho(Object json) {
    json = json as Map<String, dynamic>;
    return IpDetails(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      loc: '${json['latitude']},${json['longitude']}',
      org: json['connection']['org'],
      postal: json['postal'],
      timezone: json['timezone']['id'],
    );
  }

  factory IpDetails.onlyIP(Object json) {
    return IpDetails(
      ip: json is Map<String, dynamic> ? json['ip'] : json.toString(),
      loc: null,
      org: null,
      city: null,
      postal: null,
      region: null,
      country: null,
      timezone: null,
    );
  }

  final String? ip;
  final String? loc;
  final String? org;
  final String? city;
  final String? postal;
  final String? region;
  final String? country;
  final String? timezone;
  final String? error;

  List<String> values() {
    return [
      ip ?? '',
      loc ?? '',
      org ?? '',
      city ?? '',
      postal ?? '',
      region ?? '',
      country ?? '',
      timezone ?? '',
      error ?? '',
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      if (ip != null) 'ip': ip,
      if (loc != null) 'loc': loc,
      if (org != null) 'org': org,
      if (city != null) 'city': city,
      if (postal != null) 'postal': postal,
      if (region != null) 'region': region,
      if (country != null) 'country': country,
      if (timezone != null) 'timezone': timezone,
      if (error != null) 'error': error,
    };
  }
}
