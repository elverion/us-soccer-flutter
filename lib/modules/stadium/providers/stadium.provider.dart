import 'dart:convert';
import 'dart:io';

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
    var request =
        http.MultipartRequest("POST", Uri.parse('$serverURL/api/stadium'));
    request.fields['user'] = 'blah';
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await file.file!.readAsBytes(),
        contentType: MediaType(),
      ),
    );

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });

//     FormData formData = new FormData.from({
//    "name": "wendux",
//    "file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")
// });
// response = await dio.post("/info", data: formData)
  }

  // TODO: Upload file https://pub.dev/packages/file_picker
}

final stadiumProvider =
    StateNotifierProvider.autoDispose<StadiumProvider, List<Stadium>>(
  (ref) => StadiumProvider(ref, []),
);

class HelloWorld extends StatefulWidget {
  const HelloWorld({super.key});

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
