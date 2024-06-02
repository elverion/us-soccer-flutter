import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../location/widgets/location_text.widget.dart';
import '../models/stadium.model.dart';

class StadiumListTile extends StatelessWidget {
  final Stadium stadium;
  const StadiumListTile({
    super.key,
    required this.stadium,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.lightBlue,
      title: Text(stadium.stadium),
      subtitle: LocationText(location: stadium.location),
      trailing: IconButton(
        onPressed: () => context.go('/stadiums/stadium/${stadium.id}'),
        icon: const Icon(Icons.arrow_circle_right_outlined),
      ),
    );
  }
}
