import 'package:flutter/material.dart';

class ResponsiveFontSize {
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double scaleFactor =
        (screenWidth + screenHeight) / 800; // More balanced scaling
    return baseFontSize *
        scaleFactor.clamp(0.8, 1.2); // Prevents too small or too large text
  }
}

class ResponsiveFontSizes {
  static double fontSize60(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 30);
  }

  static double fontSize55(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 28);
  }

  static double fontSize30(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 20);
  }

  static double fontSize24(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 18);
  }

  static double fontSize22(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 17);
  }

  static double fontSize20(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 16);
  }

  static double fontSize19(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 15);
  }

  static double fontSize18(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 14);
  }

  static double fontSize17(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 13);
  }

  static double fontSize16(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 12);
  }

  static double fontSize15(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 11);
  }

  static double fontSize14(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 10);
  }

  static double fontSize13(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 9);
  }

  static double fontSize12(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 8);
  }

  static double fontSize10(BuildContext context) {
    return ResponsiveFontSize.getResponsiveFontSize(context, 7);
  }
}
