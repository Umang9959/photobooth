import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final double width;
  final double height;
  final void Function(String)? onSubmitted;
  final bool isEmail;

  CustomTextField({
    required this.controller,
    required this.focusNode,
    required this.width,
    required this.height,
    this.onSubmitted,
    this.isEmail = false,
  });

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onSubmitted: (value) {
          if (isEmail && !_isValidEmail(value)) {
            Get.snackbar(
              'Invalid Email',
              'Please enter a valid email id',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }
          if (!isEmail && value.isEmpty) {
            Get.snackbar(
              'Enter Value',
              'Please enter a value',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }
          if (onSubmitted != null) onSubmitted!(value);
        },
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Figtree',
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFC7C9CB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0.5, color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}