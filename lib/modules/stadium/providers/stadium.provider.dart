import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/const/environmentals.dart';
import 'package:us_soccer_flutter/modules/stadium/models/csv_file.model.dart';

import '../models/stadium.model.dart';

class StadiumProvider extends StateNotifier<List<Stadium>> {
  final Ref ref;

  StadiumProvider(this.ref, List<Stadium> data) : super(data);

  Stadium? getStadium(String id) {
    return state.firstWhere((stadium) => stadium.id == id);
  }

  Future<void> fetchStadiums() async {
    final response = await http.get(Uri.parse('$serverURL/api/stadiums'));

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final data = List.from(decodedResponse['stadiums'])
          .map((e) => Stadium.fromJson(e))
          .toList();

      state = data;
    } else {
      throw Exception('Failed to load stadiums');
    }
  }

  Future<void> uploadCSV(CSVFile file) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('$serverURL/api/stadiums'),
    );

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
      if (response.statusCode == 200) fetchStadiums();
    });
  }
}

final stadiumProvider =
    StateNotifierProvider.autoDispose<StadiumProvider, List<Stadium>>(
  (ref) => StadiumProvider(ref, []),
);
