import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoldText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final String fontStyle;
  final TextAlign textAlign;

  const BoldText({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.fontStyle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.getFont(
        fontStyle,
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
