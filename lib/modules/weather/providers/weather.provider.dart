import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/api/api.dart';

import '../models/weather.model.dart';

class WeatherProvider extends StateNotifier<Weather> {
  final Ref ref;
  final StadiumApi stadiumApi = StadiumApi();

  WeatherProvider(this.ref, Weather data) : super(data);

  Future<Weather> fetchWeather(String stadiumId) async {
    state = Weather();
    final response = await stadiumApi.getWeather(stadiumId);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final data = Weather.fromJson(decodedResponse['weather']);

      state = data;
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

final weatherProvider =
    StateNotifierProvider.autoDispose<WeatherProvider, Weather>(
  (ref) => WeatherProvider(ref, Weather()),
);
