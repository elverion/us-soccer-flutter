class Location {
  final String city;
  final String country;
  final double lat;
  final double long;

  Location({
    required this.city,
    required this.country,
    required this.lat,
    required this.long,
  });

  Location.fromJson(Map json)
      : city = json['city'],
        country = json['country'],
        lat = json['lat'],
        long = json['long'];
}
