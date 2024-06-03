import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:us_soccer_flutter/const/environmentals.dart';
import 'package:us_soccer_flutter/modules/stadium/models/csv_file.model.dart';
import 'package:us_soccer_flutter/modules/weather/models/weather.model.dart';

class StadiumApi {
  get http => null;

  Future<dynamic> getStadiums() async {
    print('[HERE] [GET]');
    final response = await http.get(Uri.parse('$serverURL/api/stadiums'));

    return response;
  }

  Future<dynamic> postStadiums(CSVFile file) async {
    print('[HERE] [POST]');
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('$serverURL/api/stadiums'),
    );

    // Is this application running in web or native
    Uint8List dataBytes = file.bytes ?? await file.file!.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes(
        'csv',
        dataBytes,
        filename: file.name,
        contentType: MediaType('application', 'csv'),
      ),
    );

    request.send().then((response) {
      return response;
    });
  }

  Future<Weather> getWeather(String stadiumId) async {
    final response =
        await http.get(Uri.parse('$serverURL/api/weather/$stadiumId'));

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final data = Weather.fromJson(decodedResponse['weather']);

      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
