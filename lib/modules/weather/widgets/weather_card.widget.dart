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

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: icon != null
                    ? Icon(
                        icon.icon,
                        size: 100,
                      )
                    : const SizedBox(),
              ),
              Text(
                '${weather != null ? weather?.temp : '??'}',
                style: const TextStyle(fontSize: 50),
              ),
              const SizedBox(height: 40, child: Text('\u2103')),
            ],
          ),
          Text('${weather != null ? weather?.description : '??'}'),
        ],
      ),
    );
  }
}
