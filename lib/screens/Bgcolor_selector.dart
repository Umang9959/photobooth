import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:photobooth/custom/bgcolor_grid.dart';
import 'package:photobooth/screens/strike_pose.dart';

class BgColorScreen extends StatelessWidget {
  const BgColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/detail');
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: context.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("assets/images/pickcolor.png"),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    child: BgColorGrid(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back(); // Go back to the previous page
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Image.asset(
                          "assets/images/BackButton.png",
                          height: screenHeight * 0.05,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final controller = Get.find<BgColorGridController>();
                          if (controller.isSelected.any((element) => element)) {
                            Get.to(StrikePoseScreen(
                                isselcetd: controller
                                    .selectedColorIndex)); // Navigate to the StrikePoseScreen
                          } else {
                            Get.snackbar(
                              "Select a color",
                              "Please select a color before proceeding",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 4),
                              backgroundColor: Colors.red.withOpacity(0.7),
                              colorText: Colors.white,
                            );
                          }
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Image.asset(
                          "assets/images/NextButton.png",
                          height: screenHeight * 0.05,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
