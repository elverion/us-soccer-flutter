import 'package:flutter/material.dart';

import '../models/location.model.dart';

class LocationBlock extends StatelessWidget {
  final Location location;
  const LocationBlock({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(location.country),
        Text(location.city),
      ],
    );
  }
}
