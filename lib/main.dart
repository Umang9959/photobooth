import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photobooth/screens/Bgcolor_selector.dart';
import 'package:photobooth/screens/color_pick_screen.dart';
import 'package:photobooth/screens/details_screen.dart';
import 'package:photobooth/screens/final_screen.dart';
import 'package:photobooth/screens/home_screen.dart';
import 'package:photobooth/screens/slct_bst_shot.dart';
import 'package:photobooth/screens/strike_pose.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Add these two lines to hide the status bar and task bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      title: 'Your App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/colorPick', page: () => const ColorPickScreen()),
        GetPage(name: '/bgcolor', page: () => const BgColorScreen()),
        // GetPage(name: '/strikePose', page: () => const StrikePoseScreen()),
        //GetPage(name: '/gifPreview', page: () => GifPreview()),
        GetPage(name: '/detail', page: () => DetailScreen()),
        // GetPage(name: '/gifReady', page: () => GifReady()),
        //  GetPage(name: '/dwnldgif', page: () => DownloadGifScreen()),
        GetPage(name: '/selectShot', page: () => const SelectBestShotScreen()),
        GetPage(name: '/finalscreen', page: () => const FinalScreen()),
      ],
    );
  }
}
