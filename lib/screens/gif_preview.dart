import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth/screens/dwnld_gif.dart';

class GifPreview extends StatefulWidget {
  final File imageFile;
  final int valuefromgif;

  const GifPreview({
    super.key,
    required this.imageFile,
    required this.valuefromgif,
  });

  @override
  State<GifPreview> createState() => _GifPreviewState();
}

class _GifPreviewState extends State<GifPreview> {
  var imagePath = "assets/images/Frame1.png";
  final GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.valuefromgif == 0) {
      imagePath = "assets/images/Frame1.png";
    } else if (widget.valuefromgif == 1) {
      imagePath = "assets/images/Frame2.png";
    } else if (widget.valuefromgif == 2) {
      imagePath = "assets/images/Frame3.png";
    } else {
      imagePath = "assets/images/Frame1.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Background6.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 650,
                    width: 550,
                    child: Image.file(
                      widget.imageFile,
                      fit: BoxFit.cover,
                    ),
                    // add your child widget here
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => Get.to(
                          () => DownloadGifScreen(imageFile: widget.imageFile)),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      child: Image.asset(
                        "assets/images/LikeBtn.png",
                        height: screenHeight * 0.05,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.until((route) => Get.currentRoute == '/bgcolor');
                        Get.toNamed('/bgcolor');
                      },
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      child: Image.asset(
                        "assets/images/RetakeBtn.png",
                        height: screenHeight * 0.05,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
