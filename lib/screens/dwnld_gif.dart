import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobooth/custom/medium_bold.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DownloadGifScreen extends StatefulWidget {
  final File imageFile;
  const DownloadGifScreen({super.key, required this.imageFile});
  @override
  State<DownloadGifScreen> createState() => _DownloadGifScreenState();
}

class _DownloadGifScreenState extends State<DownloadGifScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, vertical: screenHeight * 0.04),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: MediumText(
                    text: "Scan here to download your festive-ready GIF",
                    color: Color(0xFF464749),
                    size: 40,
                    fontStyle: "Figtree",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 650,
                width: 550,
                child: Image.file(
                  widget.imageFile,
                  fit: BoxFit.cover,
                ),
                // add your child widget here
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            InkWell(
              onTap: () async {
                final pdf = pw.Document();
                final image = pw.MemoryImage(widget.imageFile.readAsBytesSync());
                pdf.addPage(
                  pw.Page(
                    build: (pw.Context context) => pw.Center(
                      child: pw.Image(image),
                    ),
                  ),
                );
                await Printing.layoutPdf(
                  onLayout: (format) => pdf.save(),
                );
              },
              child: Image.asset(
                "assets/images/PrintBtn.png",
                width: screenWidth * 0.3,
                height: screenHeight * 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}