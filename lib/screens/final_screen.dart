import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobooth/custom/normal_text.dart';

import '../custom/medium_bold.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

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
                image: AssetImage("assets/images/Background8.png"),
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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisExtent: 350,
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
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: screenWidth * 0.27, // set the width
                              height: screenHeight * 0.23, // set the height
                              decoration: const BoxDecoration(
                                color: Color(0xFF58595B),
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NormalText(
                                    text: "Subramanian is all set!",
                                    color: Color(0xFF58595B),
                                    size: 20,
                                    fontStyle: "Figtree"),
                              ],
                            ),
                            const MediumText(
                                text: "#TaiyaarForTyohaar",
                                color: Color(0xFF58595B),
                                size: 10,
                                fontStyle: "Figtree")
                          ],
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
                        Get.toNamed(
                            '/dwnldgif'); // Go back to the previous page
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
