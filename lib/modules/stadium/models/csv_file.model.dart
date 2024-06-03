import 'dart:io';
import 'dart:typed_data';

class CSVFile {
  final String name;
  final int size;
  final String? path;
  final Uint8List? bytes;
  final File? file;

  CSVFile({
    required this.name,
    required this.size,
    this.path,
    this.bytes,
    this.file,
  });
}
