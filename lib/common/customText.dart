import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlusJakartaText extends StatefulWidget {
  final String? text;
  final double? lineHeight;
  final Color? color;
  final Color? decColor;
  final TextBaseline? line;
  final double? fontSize;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  const PlusJakartaText({
    super.key,
    required this.text,
    required this.color,
    this.line,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.textOverflow,
    this.decoration,
    this.decColor,
    this.lineHeight,
  });

  @override
  State<PlusJakartaText> createState() => _PlusJakartaTextState();
}

class _PlusJakartaTextState extends State<PlusJakartaText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: widget.textAlign,
      widget.text!,
      maxLines: widget.maxLines,
      overflow: widget.textOverflow,
      style: GoogleFonts.plusJakartaSans(
        decoration: widget.decoration,
        decorationColor: widget.decColor,
        letterSpacing: 0,
        height: widget.lineHeight ?? 1.5,
        color: widget.color,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        textBaseline: widget.line,
      ),
    );
  }
}
