import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/const/environmentals.dart';

import '../models/weather.model.dart';

class WeatherProvider extends StateNotifier<Weather> {
  final Ref ref;

  WeatherProvider(this.ref, Weather data) : super(data);

  Future<Weather> fetchWeather(String stadiumId) async {
    final response =
        await http.get(Uri.parse('$serverURL/api/weather/$stadiumId'));

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
