import 'package:flutter/material.dart';
import 'package:us_soccer_flutter/const/weather.enum.dart';
import 'package:us_soccer_flutter/modules/weather/models/weather.model.dart';

class WeatherCard extends StatelessWidget {
  final Weather? weather;
  const WeatherCard({
    super.key,
    this.weather,
  });

  @override
  Widget build(BuildContext context) {
    WeatherIcon? icon = weather?.icon == null
        ? null
        : WeatherIcon.getByCode(weather!.icon as String);

    return Card(
      child: Column(
        children: [
          icon != null ? Icon(icon.icon) : const SizedBox(),
          Text('Temp: ${weather != null ? weather?.temp : '??'}'),
          Text('Description: ${weather != null ? weather?.description : '??'}'),
        ],
      ),
    );
  }
}
