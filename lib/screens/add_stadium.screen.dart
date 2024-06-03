import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/modules/stadium/models/csv_file.model.dart';
import 'package:us_soccer_flutter/modules/stadium/providers/stadium.provider.dart';

class AddStadium extends ConsumerStatefulWidget {
  const AddStadium({super.key});

  @override
  ConsumerState<AddStadium> createState() => _AddStadiumState();
}

class _AddStadiumState extends ConsumerState<AddStadium> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  CSVFile? csvFile;
  FilePickerResult? localFile;
  bool isLoading = false;

  void _pickFiles() async {
    _resetState();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      localFile = result;

      if (result != null) {
        csvFile = CSVFile(
          name: result.files.single.name,
          size: result.files.single.size,
          bytes: kIsWeb ? result.files.single.bytes : null,
          path: kIsWeb ? null : result.files.single.path,
          file: kIsWeb ? null : File(result.files.single.path!),
        );
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation $e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  void _logException(String message) {
    debugPrint(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      isLoading = true;
      localFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stadiums'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.description),
                  label: const Text('Select CSV'),
                  onPressed: () => _pickFiles(),
                ),
              ),
              localFile != null
                  ? Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: SingleChildScrollView(
                        child: Card(
                          child: Column(
                            children: [
                              Text('${localFile?.files.single.name}'),
                              kIsWeb
                                  ? const SizedBox()
                                  : Text('${localFile?.files.single.path}'),
                              // kIsWeb
                              //     ? Text('${localFile?.files.single.bytes}')
                              //     : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () => {
                  if (csvFile != null)
                    ref.read(stadiumProvider.notifier).uploadCSV(csvFile!)
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
