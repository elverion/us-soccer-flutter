import 'package:us_soccer_flutter/modules/location/models/location.model.dart';

class Stadium {
  final String id;
  final String stadium;
  final Location location;

  Stadium({
    required this.id,
    required this.stadium,
    required this.location,
  });

  Stadium.fromJson(Map json)
      : id = json['id'],
        stadium = json['stadium'],
        location = Location.fromJson(json['location']);
}
