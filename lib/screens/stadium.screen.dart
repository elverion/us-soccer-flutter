import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:us_soccer_flutter/modules/stadium/providers/stadium.provider.dart';
import 'package:us_soccer_flutter/modules/stadium/widgets/stadium_card.widget.dart';
import 'package:us_soccer_flutter/modules/weather/models/weather.model.dart';
import 'package:us_soccer_flutter/modules/weather/providers/weather.provider.dart';
import 'package:us_soccer_flutter/modules/weather/widgets/weather_card.widget.dart';

class Stadium extends ConsumerStatefulWidget {
  final GoRouterState? goRouterState;

  const Stadium(this.goRouterState, {super.key});

  @override
  ConsumerState<Stadium> createState() => _StadiumState();
}

class _StadiumState extends ConsumerState<Stadium> {
  @override
  Widget build(BuildContext context) {
    final stadiumId = widget.goRouterState?.pathParameters['stadiumId'];
    final stadium = stadiumId == null
        ? null
        : ref.read(stadiumProvider.notifier).getStadium(stadiumId);
    final weather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(stadium?.stadium ?? 'Stadium not Found'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: stadium == null
            ? const Text('Stadium was not found')
            : Column(
                children: [
                  StadiumCard(stadium: stadium),
                  WeatherCard(
                    weather: weather,
                  ),
                ],
              ),
      ),
    );
  }
}
