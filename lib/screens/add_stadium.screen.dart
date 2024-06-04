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
      csvFile = null;
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
              ElevatedButton.icon(
                icon: const Icon(Icons.description),
                label: const Text('Select CSV'),
                onPressed: () => _pickFiles(),
              ),
              localFile != null
                  ? Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: SingleChildScrollView(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${localFile?.files.single.name}'),
                                kIsWeb
                                    ? const SizedBox()
                                    : Text('${localFile?.files.single.path}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 100),
              ElevatedButton(
                onPressed: () async {
                  if (!isLoading && csvFile != null) {
                    final result = await ref
                        .read(stadiumProvider.notifier)
                        .uploadCSV(csvFile!);
                    _resetState();

                    setState(() {
                      isLoading = false;
                    });

                    final snackBar = SnackBar(
                      content: Text(result
                          ? 'Stadiums added successfully'
                          : 'An error occurred'),
                      action: SnackBarAction(
                        label: 'X',
                        onPressed: () {},
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    isLoading || csvFile == null
                        ? Theme.of(context).primaryColor.withOpacity(0.5)
                        : Theme.of(context).primaryColor,
                  ),
                  foregroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
