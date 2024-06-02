import 'package:flutter/material.dart';
import 'package:us_soccer_flutter/modules/location/widgets/location_block.widget.dart';

import '../models/stadium.model.dart';

class StadiumCard extends StatelessWidget {
  final Stadium stadium;
  const StadiumCard({
    super.key,
    required this.stadium,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(stadium.stadium),
          LocationBlock(location: stadium.location),
        ],
      ),
    );
  }
}
