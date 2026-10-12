import 'package:flutter/material.dart';

class MyColors extends ThemeExtension<MyColors> {
  MyColors({
    required this.txt,
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.accentTxt,
    required this.bg1,
    required this.bgColor,
    required this.surface,
    required this.error,
    required this.bgGray,
    required this.textGray,
    required this.litegray,
    required this.darkGray,
    required this.lightGray,
    required this.borderGray,
    required this.green,
    required this.white,
    required this.whiteColor,
    required this.blackText,
    required this.blackColor,
    required this.textColor,
    required this.contentColor,
    required this.borderColor,
    required this.greenColor,
    required this.darkContentColor,
    required this.ratingColor,
    required this.homeCategoryColor,
    required this.greyLight25,
    required this.primaryText,
    required this.primaryLableText,
    required this.pink,
    required this.amber,
  });

  final Color? txt;
  final Color primary;
  final Color? primaryLight;
  final Color? secondary;
  final Color? accentTxt;
  final Color? bg1;
  final Color? bgColor;
  final Color? surface;
  final Color? error;
  final Color? bgGray;
  final Color? textGray;
  final Color? litegray;
  final Color? darkGray;
  final Color? lightGray;
  final Color? borderGray;
  final Color? green;
  final Color? white;
  final Color? whiteColor;
  final Color? blackText;
  final Color? blackColor;
  final Color? textColor;
  final Color? contentColor;
  final Color? borderColor;
  final Color? greenColor;
  final Color? darkContentColor;
  final Color? ratingColor;
  final Color? homeCategoryColor;
  final Color? greyLight25;
  final Color? primaryText;
  final Color? primaryLableText;
  final Color? pink;
  final Color? amber;

  @override
  MyColors copyWith({
    Color? txt,
    Color? primary,
    Color? primaryLight,
    Color? secondary,
    Color? accentTxt,
    Color? bg1,
    Color? bgColor,
    Color? surface,
    Color? error,
    Color? bgGray,
    Color? litegray,
    Color? darkGray,
    Color? lightGray,
    Color? textGray,
    Color? borderGray,
    Color? green,
    Color? white,
    Color? whiteColor,
    Color? blackText,
    Color? blackColor,
    Color? textColor,
    Color? contentColor,
    Color? borderColor,
    Color? greenColor,
    Color? darkContentColor,
    Color? ratingColor,
    Color? homeCategoryColor,
    Color? greyLight25,
    Color? primaryText,
    Color? primaryLableText,
    Color? red,
  }) {
    return MyColors(
      txt: txt ?? this.txt,
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      secondary: secondary ?? this.secondary,
      accentTxt: accentTxt ?? this.accentTxt,
      bg1: bg1 ?? this.bg1,
      bgColor: bgColor ?? this.bgColor,
      surface: surface ?? this.surface,
      error: error ?? this.error,
      bgGray: bgGray ?? this.bgGray,
      litegray: litegray ?? this.litegray,
      darkGray: darkGray ?? this.darkGray,
      lightGray: lightGray ?? this.lightGray,
      borderGray: borderGray ?? this.borderGray,
      textGray: textGray ?? this.textGray,
      green: green ?? this.green,
      white: white ?? this.white,
      whiteColor: whiteColor ?? this.whiteColor,
      blackText: blackText ?? this.blackText,
      blackColor: blackColor ?? this.blackColor,
      textColor: textColor ?? this.textColor,
      contentColor: contentColor ?? this.contentColor,
      borderColor: borderColor ?? this.borderColor,
      greenColor: greenColor ?? this.greenColor,
      darkContentColor: darkContentColor ?? this.darkContentColor,
      ratingColor: ratingColor ?? this.ratingColor,
      homeCategoryColor: homeCategoryColor ?? this.homeCategoryColor,
      greyLight25: greyLight25 ?? this.greyLight25,
      primaryText: primaryText ?? this.primaryText,
      primaryLableText: primaryLableText ?? this.primaryLableText,
      pink: red ?? pink,
      amber: red ?? amber,
    );
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      txt: Color.lerp(txt, other.txt, t),
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      accentTxt: Color.lerp(accentTxt, other.accentTxt, t),
      bg1: Color.lerp(bg1, other.bg1, t),
      bgColor: Color.lerp(bgColor, other.bgColor, t),
      surface: Color.lerp(surface, other.surface, t),
      error: Color.lerp(error, other.error, t),
      bgGray: Color.lerp(bgGray, other.bgGray, t),
      litegray: Color.lerp(litegray, other.litegray, t),
      darkGray: Color.lerp(darkGray, other.darkGray, t),
      textGray: Color.lerp(textGray, other.textGray, t),
      lightGray: Color.lerp(lightGray, other.lightGray, t),
      borderGray: Color.lerp(borderGray, other.borderGray, t),
      green: Color.lerp(green, other.green, t),
      white: Color.lerp(white, other.white, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      blackText: Color.lerp(blackText, other.blackText, t),
      blackColor: Color.lerp(blackColor, other.blackColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      contentColor: Color.lerp(contentColor, other.contentColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      greenColor: Color.lerp(greenColor, other.greenColor, t),
      darkContentColor: Color.lerp(darkContentColor, other.darkContentColor, t),
      ratingColor: Color.lerp(ratingColor, other.ratingColor, t),
      homeCategoryColor: Color.lerp(
        homeCategoryColor,
        other.homeCategoryColor,
        t,
      ),
      greyLight25: Color.lerp(greyLight25, other.greyLight25, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      primaryLableText: Color.lerp(primaryLableText, other.primaryLableText, t),
      pink: Color.lerp(pink, other.pink, t),
      amber: Color.lerp(amber, other.amber, t),
      // brandColor: Color.lerp(brandColor, other.brandColor, t),
      // danger: Color.lerp(danger, other.danger, t),
    );
  }
}
