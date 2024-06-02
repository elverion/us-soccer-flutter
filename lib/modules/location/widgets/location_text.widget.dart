import 'package:flutter/material.dart';

import '../models/location.model.dart';

class LocationText extends StatelessWidget {
  final Location location;
  const LocationText({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Text('${location.country}, ${location.city}');
  }
}
