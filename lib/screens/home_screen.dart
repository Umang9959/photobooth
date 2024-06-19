import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photobooth/custom/bold_text.dart';
import 'package:photobooth/screens/details_screen.dart';

import '../custom/medium_bold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      BoldText(
                        text: "Welcome to ",
                        color: Colors.white,
                        size: screenWidth * 0.07,
                        fontStyle: "Open Sans",
                      ),
                      MediumText(
                        text: "#TaiyaarForTyohaar",
                        color: Colors.white,
                        size: screenWidth * 0.045,
                        fontStyle: "Open Sans",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Image.asset("assets/images/ReadyButton.png"),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed('/detail'); // Navigate to the DetailScreen
                  },
                  child: Image.asset(
                    "assets/images/NextButton.png",
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.1,
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