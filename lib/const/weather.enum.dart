import 'package:flutter/material.dart';

enum WeatherIcon {
  clearSkyDay(code: '01d', icon: Icons.wb_sunny_outlined),
  clearSkyNight(code: '01n', icon: Icons.sunny),
  fewCloudsDay(code: '02d', icon: Icons.cloud_outlined),
  fewCloudsNight(code: '02n', icon: Icons.cloud),
  scatteredCloudsDay(code: '03d', icon: Icons.cloud_outlined),
  scatteredCloudsNight(code: '03n', icon: Icons.cloud),
  brokenCloudsDay(code: '04d', icon: Icons.cloud_outlined),
  brokenCloudsNight(code: '04n', icon: Icons.cloud),
  showerRainDay(code: '09d', icon: Icons.cloud_outlined),
  showerRainNight(code: '09n', icon: Icons.cloud),
  rainDay(code: '10d', icon: Icons.cloud_outlined),
  rainNight(code: '10n', icon: Icons.cloud),
  thunderstormDay(code: '11d', icon: Icons.cloud_outlined),
  thunderstormNight(code: '11n', icon: Icons.cloud),
  snowDay(code: '13d', icon: Icons.snowshoeing_outlined),
  snowNight(code: '13n', icon: Icons.snowing),
  mistDay(code: '50d', icon: Icons.cloud_outlined),
  mistNight(code: '50n', icon: Icons.cloud);

  final String code;
  final IconData icon;
  const WeatherIcon({
    required this.code,
    required this.icon,
  });

  static WeatherIcon getByCode(String code) {
    return WeatherIcon.values.firstWhere((value) => value.code == code);
  }
}
