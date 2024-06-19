import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgColorGrid extends StatefulWidget {
  @override
  State<BgColorGrid> createState() => _BgColorGridState();
}

class _BgColorGridState extends State<BgColorGrid> {
  @override
  void initState() {
    super.initState();
    Get.put(BgColorGridController()); // Initialize the controller here
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BgColorGridController>(
      builder: (controller) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 40,
            mainAxisSpacing: 40,
          ),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.selectItem(index);
              },
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: getColor(index),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: controller.isSelected[index]
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          weight: 20,
                          size: 50,
                        )
                      : null,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFE9800);
      case 1:
        return const Color(0xFF006FBB);
      case 2:
        return const Color(0xFF19A143);
      case 3:
        return const Color(0xFFE92F22);
      default:
        return Colors.grey;
    }
  }
}

class BgColorGridController extends GetxController {
  List<bool> _isSelected = [false, false, false, false];
  int _selectedColorIndex = -1;

  List<bool> get isSelected => _isSelected;

  int get selectedColorIndex => _selectedColorIndex;

  void selectItem(int index) {
    if (_isSelected[index]) {
      _isSelected[index] = false;
      _selectedColorIndex = -1;
    } else {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
      _selectedColorIndex = index;
    }
    update();
  }
}
