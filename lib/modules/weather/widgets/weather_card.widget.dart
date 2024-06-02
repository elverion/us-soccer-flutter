import 'package:flutter/material.dart';
import 'package:us_soccer_flutter/modules/weather/models/weather.model.dart';

class WeatherCard extends StatelessWidget {
  final Weather? weather;
  const WeatherCard({
    super.key,
    this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Temp: ${weather != null ? weather?.temp : '??'}'),
          Text('Description: ${weather != null ? weather?.description : '??'}'),
        ],
      ),
    );
  }
}
