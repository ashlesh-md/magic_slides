import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:magic_slides/core/exceptions/file_exception.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<File> downloadFile(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw FileException("Failed to download file");
    }

    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/$fileName";

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes, flush: true);

    return file;
  }
}
