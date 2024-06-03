import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:us_soccer_flutter/modules/weather/providers/weather.provider.dart';

import '../../location/widgets/location_text.widget.dart';
import '../models/stadium.model.dart';

class StadiumListTile extends ConsumerWidget {
  final Stadium stadium;
  const StadiumListTile({
    super.key,
    required this.stadium,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      hoverColor: Colors.lightBlue,
      title: Text(stadium.stadium),
      subtitle: LocationText(location: stadium.location),
      trailing: IconButton(
        onPressed: () {
          ref.read(weatherProvider.notifier).fetchWeather(stadium.id);
          context.go('/stadiums/stadium/${stadium.id}');
        },
        icon: const Icon(Icons.arrow_circle_right_outlined),
      ),
    );
  }
}
