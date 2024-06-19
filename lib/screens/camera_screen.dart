import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth/custom/medium_bold.dart';
import 'package:photobooth/screens/gifscreen.dart';

import 'image_preview.dart';

class CameraMainScreen extends StatefulWidget {
  final int colorvalue;

  const CameraMainScreen({super.key, required this.colorvalue});

  @override
  State<CameraMainScreen> createState() => _CameraMainScreenState();
}

class _CameraMainScreenState extends State<CameraMainScreen>
    with WidgetsBindingObserver {
  bool _isBlinkingCounter = false;
  late CameraController _controller;
  int _activeCameraIndex = 1; // Change this to 1 for the front camera
  bool _isCameraInitialized = false;
  int _countdownSeconds = 0;
  Timer? _countdownTimer;

  List<XFile> capturedImages = [];
  int burstImageIndex = 1;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    } else if (state == AppLifecycleState.paused) {
      _controller.dispose();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _initializeCamera() async {
    if (_isCameraInitialized) return;
    List<CameraDescription> cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      CameraDescription description = cameras[_activeCameraIndex];
      _controller = CameraController(description, ResolutionPreset.ultraHigh);
      await _controller.initialize();
      if (!mounted) {
        return;
      }
      setState(() {
        _isCameraInitialized = true;
      });
    } else {
      throw 'No camera found';
    }
  }

  void _toggleCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    setState(() {
      _activeCameraIndex = (_activeCameraIndex + 1) % cameras.length;
      _controller.dispose();
      _isCameraInitialized = false;
      _initializeCamera();
    });
  }

  void _startCountdown() {
    setState(() {
      _countdownSeconds = 3;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _countdownSeconds--;
          if (_countdownSeconds == 0) {
            _countdownTimer?.cancel();
            _takePicture();
          }
        });
      });
    });
  }

  Future<void> _takePicture() async {
    for (int i = 0; i < 5; i++) {
      try {
        setState(() {
          _isBlinkingCounter = true;
        });
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() {
          _isBlinkingCounter = false;
        });
        await Future.delayed(const Duration(milliseconds: 300));

        XFile? xFile = await _controller.takePicture();
        if (xFile != null) {
          if (mounted) {
            setState(() {
              capturedImages.add(xFile);
              burstImageIndex++;
            });
          }
        }
      } catch (e) {
        print(e);
      }
      await Future.delayed(const Duration(milliseconds: 300));
    }

    if (mounted) {
      await Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => GifScreen(
            capturedImages: capturedImages,
            onRetakePressed: () {
              setState(() {
                _controller.dispose();
                _isCameraInitialized = false;
                _initializeCamera();
                capturedImages.clear();
                burstImageIndex = 1;
              });
              Navigator.pop(context);
            },
            valuefromstrik: widget.colorvalue,
          ),
        ),
      );
    }
  }

  Future<File> flipImageHorizontal(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final img.Image? image = img.decodeImage(bytes);
    final img.Image flippedImage = img.flipHorizontal(image!);
    final bytesFlipped = img.encodeJpg(flippedImage);
    await imageFile.writeAsBytes(bytesFlipped);
    return imageFile;
  }

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width * 0.05;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/bgcolor');
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Background4.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _isCameraInitialized
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          width: MediaQuery.of(context).size.width * 0.64,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CameraPreview(_controller),
                              if (_countdownSeconds > 0)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Text(
                                        _countdownSeconds.toString(),
                                        style: const TextStyle(
                                          fontSize: 120,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (_isBlinkingCounter)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(radius),
                                  ),
                                )
                              else
                                Container(),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.withOpacity(0.4),
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 30,
                              ),
                              minimumSize: const Size(150, 60),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _startCountdown,
                            child: const MediumText(
                                text: "Take Picture",
                                color: Colors.white,
                                size: 20,
                                fontStyle: "Open Sans"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          ElevatedButton(
                            onPressed: _toggleCamera,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.4),
                              minimumSize: const Size(50, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(
                              Icons.switch_camera_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                        ],
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
