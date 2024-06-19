import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobooth/custom/bold_text.dart';
import 'package:photobooth/custom/textfield.dart';
import 'package:photobooth/screens/color_pick_screen.dart';

class DetailScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/');
        return false;
      },
      child: GestureDetector(
        onTap: () {
          _nameFocusNode.unfocus();
          _emailFocusNode.unfocus();
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Backgroun2.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Image.asset("assets/images/EnterDetails.png"),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BoldText(
                                text: "Name :",
                                color: Color(0xFF464749),
                                size: 45,
                                fontStyle: "Open Sans",
                              ),
                              CustomTextField(
                                controller: nameController,
                                focusNode: _nameFocusNode,
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.5,
                                onSubmitted: (value) {
                                  if (value.isEmpty) {
                                    Get.snackbar(
                                      'Enter Name',
                                      'Please enter your name',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }
                                  _emailFocusNode.requestFocus();
                                },
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BoldText(
                                text: "Email ID :",
                                color: Color(0xFF464749),
                                size: 45,
                                fontStyle: "Open Sans",
                              ),
                              CustomTextField(
                                controller: emailController,
                                focusNode: _emailFocusNode,
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.5,
                                isEmail: true,
                                onSubmitted: (value) {
                                  if (value.isEmpty) {
                                    Get.snackbar(
                                      'Enter Email',
                                      'Please enter your email id',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.offAllNamed('/');
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
                            _nameFocusNode.unfocus();
                            _emailFocusNode.unfocus();
                            if (nameController.text.isEmpty) {
                              Get.snackbar(
                                'Enter Name',
                                'Please enter your name',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }
                            if (emailController.text.isEmpty) {
                              Get.snackbar(
                                'Enter Email',
                                'Please enter your email id',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }
                            if (!_isValidEmail(emailController.text)) {
                              Get.snackbar(
                                'Invalid Email',
                                'Please enter a valid email id',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                              return;
                            }
                            Get.toNamed('/bgcolor');
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
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }
}
