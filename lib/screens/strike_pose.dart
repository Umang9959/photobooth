import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobooth/screens/camera_screen.dart';

class StrikePoseScreen extends StatefulWidget {
  final int isselcetd;
  const StrikePoseScreen( {Key? key,required this.isselcetd,}) : super(key: key);

  @override
  _StrikePoseScreenState createState() => _StrikePoseScreenState();
}

class _StrikePoseScreenState extends State<StrikePoseScreen> {
  @override
  void initState() {
    super.initState();
    print("iscolorvalue${widget.isselcetd}");
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => CameraMainScreen(colorvalue:widget.isselcetd));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Background3.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 450,
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Strike your ",
                      style: TextStyle(
                        fontSize: 90,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF464749),
                        fontFamily: "Figtree",
                      ),
                    ),
                    TextSpan(
                      text: "favourite pose",
                      style: TextStyle(
                        fontSize: 90,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF006FBB),
                        fontFamily: "Figtree",
                      ),
                    ),
                    TextSpan(
                      text: " in...",
                      style: TextStyle(
                        fontSize: 90,
                        color: Color(0xFF464749),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Figtree",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
