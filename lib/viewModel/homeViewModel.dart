import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends GetxController {
  RxBool isloading = false.obs;
Future<String> downloadFile(url) async {
    try {
      // Download the PDF file
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();

        // Create a file path for the PDF
        final filePath = '${tempDir.path}/downloaded_pdf.pdf';

        // Write the PDF file to the temporary directory
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Return the file path
        await savePath(url, file.path);
        Get.snackbar('Done', 'File downloaded. Open it now');
        return file.path;
      } else {
        throw Exception('Failed to download PDF');
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
      throw Exception('Error downloading PDF: $e');
    }
  }

  savePath(key, path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('$key', '$path');
  }

  getPath(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('$key');
  }

  Future<bool> checkKeyExists(key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
