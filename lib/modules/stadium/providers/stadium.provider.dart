import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/api/api.dart';
import 'package:us_soccer_flutter/modules/stadium/models/csv_file.model.dart';

import '../models/stadium.model.dart';

class StadiumProvider extends StateNotifier<List<Stadium>> {
  final Ref ref;
  final StadiumApi stadiumApi = StadiumApi();

  StadiumProvider(this.ref, List<Stadium> data) : super(data) {
    // Fetch initial stadiums
    fetchStadiums();
  }

  Stadium? getStadium(String id) {
    return state.firstWhere((stadium) => stadium.id == id);
  }

  Future<void> fetchStadiums() async {
    final response = await stadiumApi.getStadiums();

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

  Future<bool> uploadCSV(CSVFile file) async {
    final response = await stadiumApi.postStadiums(file);

    fetchStadiums();

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}

final stadiumProvider =
    StateNotifierProvider.autoDispose<StadiumProvider, List<Stadium>>(
  (ref) => StadiumProvider(ref, []),
);
