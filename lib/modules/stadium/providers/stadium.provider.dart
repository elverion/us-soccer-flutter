import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/const/environmentals.dart';

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

  // TODO: Upload file https://pub.dev/packages/file_picker
}

final stadiumProvider =
    StateNotifierProvider.autoDispose<StadiumProvider, List<Stadium>>(
  (ref) => StadiumProvider(ref, []),
);
