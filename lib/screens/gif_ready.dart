import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobooth/custom/medium_bold.dart';
import 'package:photobooth/screens/details_screen.dart';
import 'package:photobooth/screens/gif_preview.dart';

class GifReady extends StatefulWidget {
  final File imageFile;
  final int valuefrompreview;

  const GifReady({
    super.key,
    required this.imageFile,
    required this.valuefrompreview,
  });

  @override
  State<GifReady> createState() => _GifReadyState();
}

class _GifReadyState extends State<GifReady> {
  var imagePath = "assets/images/Frame1.png";

  @override
  void initState() {
    super.initState();

    if (widget.valuefrompreview == 0) {
      imagePath = "assets/images/Frame1.png";
    } else if (widget.valuefrompreview == 1) {
      imagePath = "assets/images/Frame2.png";
    } else if (widget.valuefrompreview == 2) {
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
                image: AssetImage("assets/images/Background5.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: MediumText(
                          text: "Your GIF is ready !",
                          color: Color(0xFF464749),
                          size: 80,
                          fontStyle: "Open Sans"),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                  child: InkWell(
                    child: Image.asset("assets/images/TapViewBtn.png"),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      Get.to(GifPreview(
                          imageFile: widget.imageFile,
                          valuefromgif: widget.valuefrompreview));
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
