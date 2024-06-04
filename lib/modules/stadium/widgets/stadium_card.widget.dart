import 'package:flutter/material.dart';
import 'package:us_soccer_flutter/modules/location/widgets/location_text.widget.dart';

import '../models/stadium.model.dart';

class StadiumCard extends StatelessWidget {
  final Stadium stadium;
  const StadiumCard({
    super.key,
    required this.stadium,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stadium.stadium,
            style:
                const TextStyle(fontSize: 30, overflow: TextOverflow.ellipsis),
          ),
          LocationText(location: stadium.location),
        ],
      ),
    );
  }
}
