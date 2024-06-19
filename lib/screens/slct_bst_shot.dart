import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

class SelectBestShotScreen extends StatelessWidget {
  const SelectBestShotScreen({super.key});

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
                image: AssetImage("assets/images/Background7.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/slctShotBtn.png"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisExtent: 250,
                      // calculate the aspect ratio
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(4, (index) {
                      return Container(
                        width: 50, // set the width
                        height: 100, // set the height
                        decoration: const BoxDecoration(
                          color: Color(0xFF58595B),
                        ),
                      );
                    }),
                  ),
                ),
                // SizedBox(
                //   height: screenHeight * 0.1,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.until((route) => Get.currentRoute == '/');
                        Get.toNamed('/'); // Navigate to the ColorPickScreen
                      },
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      child: Image.asset(
                        "assets/images/HomeBtn.png",
                        height: screenHeight * 0.05,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/finalscreen'); // Go back to the previous page
                      },
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                      child: Image.asset(
                        "assets/images/PrintBtn.png",
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
