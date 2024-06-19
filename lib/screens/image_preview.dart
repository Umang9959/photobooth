import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth/screens/gif_ready.dart';
import '../custom/medium_bold.dart';

class ImageScreen extends StatefulWidget {
  final File imageFile;
  final VoidCallback onRetakePressed;

  ImageScreen({
    super.key,
    required this.imageFile,
    required this.onRetakePressed,
    required this.valuefromstrik,
  });

  final int valuefromstrik;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var imagePath = "assets/images/Frame1.png";
  bool _isLoading = false;
  final String _apiKey = 'gExiYjFhj66nAdu6aigdz1tZ'; // Your Remove.bg API key

  @override
  void initState() {
    super.initState();
    print("Imagescreen${widget.valuefromstrik}");
    if (widget.valuefromstrik == 0) {
      imagePath = "assets/images/Frame1.png";
    } else if (widget.valuefromstrik == 1) {
      imagePath = "assets/images/Frame2.png";
    } else if (widget.valuefromstrik == 2) {
      imagePath = "assets/images/Frame3.png";
    } else {
      imagePath = "assets/images/Frame1.png";
    }
  }

  Future<File?> removeImageBackground(File imageFile) async {
    setState(() => _isLoading = true);
    String apiUrl = 'https://api.remove.bg/v1.0/removebg';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['X-Api-Key'] = _apiKey;

    var multipartFile = await http.MultipartFile.fromPath(
      'image_file',
      imageFile.path,
      filename: basename(imageFile.path),
    );

    // var bgImageFile = await http.MultipartFile.fromPath(
    //   'bg_image_file',
    //   imagePath,
    //   filename: basename(imagePath),
    // );

    // request.fields['bg_image_file'] = imagePath;
    request.files.add(multipartFile);
    // request.files.add(bgImageFile);

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

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width * 0.05;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: SizedBox(
                  height: screenHeight * 0.7,
                  width: screenWidth * 0.7,
                  child: Image.file(
                    widget.imageFile,
                    fit: BoxFit.fill,
                  ),
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
                    onTap: _isLoading
                        ? null
                        : () async {
                      File? processedImageFile =
                      await removeImageBackground(widget.imageFile);
                      if (processedImageFile != null) {
                        Get.to(() => GifReady(
                            imageFile: processedImageFile,
                            valuefrompreview: widget.valuefromstrik));
                      } else {
                        Get.snackbar('Error', 'Failed to process image');
                      }
                    },
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Image.asset(
                      "assets/images/LikeBtn.png",
                      height: screenHeight * 0.05,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.1),
                  InkWell(
                    onTap: () {
                      Get.to(() => GifReady(
                        imageFile: widget.imageFile,
                        valuefrompreview: widget.valuefromstrik,
                      ));
                    },
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Image.asset(
                      "assets/images/LikeBtn.png",
                      height: screenHeight * 0.05,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
