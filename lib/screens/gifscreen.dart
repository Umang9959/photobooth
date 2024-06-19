import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gify/gify.dart';

import 'gif_ready.dart';

class GifScreen extends StatefulWidget {
  final List<XFile> capturedImages;
  final VoidCallback onRetakePressed;

  GifScreen({
    required this.capturedImages,
    required this.onRetakePressed,
    required this.valuefromstrik,
  });

  final int valuefromstrik;

  @override
  _GifScreenState createState() => _GifScreenState();
}

class _GifScreenState extends State<GifScreen> {
  List<File> processedImages = [];
  bool _isLoading = false;
  final String _apiKey = 'gExiYjFhj66nAdu6aigdz1tZ'; // Your Remove.bg API key

  @override
  void initState() {
    super.initState();
    _processImages();
  }

  String getColorName(int index) {
    switch (index) {
      case 0:
        return 'yellow';
      case 1:
        return 'blue';
      case 2:
        return 'green';
      case 3:
        return 'red';
      default:
        return 'grey';
    }
  }

  Future<void> _processImages() async {
    setState(() => _isLoading = true);
    int colorIndex = 0;
    for (var xFile in widget.capturedImages) {
      String bgColor = getColorName(widget.valuefromstrik);
      File? processedImage =
      await removeImageBackground(File(xFile.path), bgColor);
      if (processedImage != null) {
        processedImages.add(processedImage);
      }
      colorIndex = (colorIndex + 1) % 4; // Cycle through the colors
    }
    setState(() => _isLoading = false);
  }

  Future<File?> removeImageBackground(File imageFile, String bgColor) async {
    setState(() => _isLoading = true);
    String apiUrl = 'https://api.remove.bg/v1.0/removebg';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['X-Api-Key'] = _apiKey;
    request.fields['bg_color'] = bgColor; // Add the bg_color field

    var multipartFile = await http.MultipartFile.fromPath(
      'image_file',
      imageFile.path,
      filename: basename(imageFile.path),
    );

    request.files.add(multipartFile);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File outputFile = File(
            '$tempPath/output_${DateTime.now().millisecondsSinceEpoch}.png');
        await outputFile.writeAsBytes(await response.stream.toBytes());
        print('Processed image saved to: ${outputFile.path}');
        return outputFile;
      } else {
        print('Background removal failed with status ${response.statusCode}');
        var responseBody = await response.stream.bytesToString();
        print('Error: $responseBody');
        return null;
      }
    } catch (e) {
      print('Error removing background: $e');
      return null;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> createGif() async {
    if (processedImages.isEmpty)
      return;

    final gifyPlugin = Gify();
    final List<XFile> imageFiles =
    processedImages.map((file) => XFile(file.path)).toList();

    final gifBytes = await gifyPlugin.createGifFromImages(
      imageFiles,
      fps: 3, // Adjust the frames per second (fps) as needed
      width: 300, // Adjust the width as needed
      height: 580, // Adjust the height as needed
    );

    if (gifBytes != null) {
      final tempDir = await getTemporaryDirectory();
      final gifFile = File('${tempDir.path}/output.gif');
      await gifFile.writeAsBytes(gifBytes);

      // Navigate to the GifReady screen with the created GIF file
      Get.to(() => GifReady(
        imageFile: gifFile,
        valuefrompreview: widget.valuefromstrik,
      ));
    } else {
      // Handle the case where GIF creation failed
      print('GIF creation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width * 0.05;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        widget.onRetakePressed();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Background4.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                SizedBox(
                  height: screenHeight * 0.7,
                  width: screenWidth * 0.7,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: processedImages.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: Image.file(
                          processedImages[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: widget.onRetakePressed,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      child: Image.asset(
                        "assets/images/RetakeBtn.png",
                        height: screenHeight * 0.05,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    InkWell(
                      onTap: createGif,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Image.asset(
                        "assets/images/LikeBtn.png",
                        height: screenHeight * 0.05,
                      ),
                    )
                    // Add your existing "Like" button here
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}