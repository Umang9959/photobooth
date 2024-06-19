import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> removeImageBackground(File imageFile, String apiKey) async {
  // API URL
  String apiUrl = 'https://api.remove.bg/v1.0/removebg';

  // Create a multipart request
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  // Set the API key in the headers
  request.headers['X-Api-Key'] = apiKey;

  // Create a multipart file from the image file
  var multipartFile = await http.MultipartFile.fromPath(
    'image_file', // The API expects the file with this field name
    imageFile.path,
    filename: basename(imageFile.path),
  );

  // Add the file to the request
  request.files.add(multipartFile);

  try {
    // Send the request
    var response = await request.send();

    // Check the response
    if (response.statusCode == 200) {
      print('Background removed successfully');

      // Get the app's temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Create a file to save the processed image
      File outputFile =
          File('$tempPath/output_${DateTime.now().millisecondsSinceEpoch}.png');
      await outputFile.writeAsBytes(await response.stream.toBytes());
      print('Processed image saved to: ${outputFile.path}');

      return outputFile;
    } else {
      print('Background removal failed with status ${response.statusCode}');
      // Print error message if available
      var responseBody = await response.stream.bytesToString();
      print('Error: $responseBody');
      return null;
    }
  } catch (e) {
    print('Error removing background: $e');
    return null;
  }
}
