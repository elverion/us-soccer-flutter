import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FileUploadButton extends StatefulWidget {
  const FileUploadButton({super.key});

  @override
  State<FileUploadButton> createState() => _FileUploadButtonState();
}

class _FileUploadButtonState extends State<FileUploadButton> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  FilePickerResult? _localFile;
  String? _directoryPath;
  bool _isLoading = false;
  bool _userAborted = false;

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _localFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['csv'],
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation $e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _localFile != null ? _localFile?.files.single.name.toString() : '...';
      _userAborted = _localFile == null;
    });
  }

  void _logException(String message) {
    // print(message);
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
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _localFile = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.description),
          label: const Text('UPLOAD FILE'),
          onPressed: () => _pickFiles(),
        ),
        _localFile != null
            ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Card(
                  child: Column(
                    children: [
                      Text('${_localFile?.files.single.name}'),
                      kIsWeb
                          ? const SizedBox()
                          : Text('${_localFile?.files.single.path}'),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
