// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../screens/image_preview.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late CameraController _controller;
  bool _isControllerInitialized = false;
  int _selectedCameraIndex = 1; // 1 for front camera, 0 for rear camera

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
    super.dispose();
  }

  void _initializeCamera() async {
    if (_isControllerInitialized) return;
    List<CameraDescription> cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      CameraDescription description = cameras[_selectedCameraIndex];
      _controller = CameraController(
        description,
        ResolutionPreset.ultraHigh,
        fps: 120,
        enableAudio: true,
      );
      await _controller.initialize();
      _isControllerInitialized = true;
      if (!mounted) {
        return;
      }
      setState(() {});
    } else {
      throw 'No camera found';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isControllerInitialized || !_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
      ),
    );
  }
}