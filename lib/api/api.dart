import 'dart:typed_data';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart'; // Required for MediaType

import 'package:http/http.dart' as http;
import 'package:us_soccer_flutter/const/environmentals.dart';
import 'package:us_soccer_flutter/modules/stadium/models/csv_file.model.dart';

class StadiumApi {
  Future<dynamic> getStadiums() async {
    final response = await http.get(Uri.parse('$serverURL/api/stadiums'));

    return response;
  }

  Future<dynamic> postStadiums(CSVFile file) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('$serverURL/api/stadiums'),
    );

    // Is this application running in web or native
    Uint8List dataBytes = file.bytes ?? await file.file!.readAsBytes();

    // Construct payload
    request.files.add(
      http.MultipartFile.fromBytes(
        'csv',
        dataBytes,
        filename: file.name,
        contentType: MediaType('application', 'csv'),
      ),
    );

    final response = await request.send();
    return response;
  }

  Future<dynamic> getWeather(String stadiumId) async {
    final response =
        await http.get(Uri.parse('$serverURL/api/weather/$stadiumId'));

    return response;
  }
}
