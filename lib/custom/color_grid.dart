import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorGridView extends StatefulWidget {
  @override
  State<ColorGridView> createState() => _ColorGridViewState();
}

class _ColorGridViewState extends State<ColorGridView> {
  @override
  void initState() {
    super.initState();
    Get.put(ColorGridViewController()); // Initialize the controller here
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorGridViewController>(
      builder: (controller) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 30,
          ),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.selectItem(index);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    getImagePath(index),
                    fit: BoxFit.cover,
                  ),
                  if (controller.isSelected[index])
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline_sharp,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return "assets/images/Frame1.png";
      case 1:
        return "assets/images/Frame2.png";
      case 2:
        return "assets/images/Frame3.png";
      case 3:
        return "assets/images/Frame1.png";
      default:
        return "assets/images/default.png"; // Make sure you have a default image
    }
  }
}

class ColorGridViewController extends GetxController {
  List<bool> _isSelected = [false, false, false, false];
  int _selectedFrameIndex = -1;

  List<bool> get isSelected => _isSelected;

  int get selectedFrameIndex => _selectedFrameIndex;

  void selectItem(int index) {
    if (_isSelected[index]) {
      _isSelected[index] = false;
      _selectedFrameIndex = -1;
    } else {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
      _selectedFrameIndex = index;
    }
    update();
  }
}
