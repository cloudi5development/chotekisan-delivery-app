import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';

class CustomTextfield extends StatelessWidget {
  final String text;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextfield({
    super.key,
    required this.text,
    required this.textEditingController,
    this.maxLength,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return SizedBox(
      height: height * 0.07,
      child: Center(
        child: TextField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          controller: textEditingController,
          // maxLength: maxLength,
          maxLines: maxLength,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16, bottom: 8),
            hintText: text,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle: TextStyle(
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: Colors.black.withOpacity(.5),
              fontSize: ResponsiveFontSizes.fontSize15(context),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(.5),
                width: 0.1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextfield1 extends StatelessWidget {
  final String text;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController textEditingController;

  const CustomTextfield1({
    super.key,
    required this.text,
    required this.textEditingController,
    this.maxLength,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 44,
      child: TextField(
        controller: textEditingController,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Color(0xff727271).withOpacity(0.7),
            fontFamily: "sfpro",
            fontSize: ResponsiveFontSizes.fontSize16(context),
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class CustomPhoneTextfield extends StatelessWidget {
  final String label;
  final String hintText;
  final String countryCode;
  final bool isRequired;
  final int maxLength;
  final TextEditingController textEditingController;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const CustomPhoneTextfield({
    super.key,
    required this.textEditingController,
    this.label = "Phone Number",
    this.hintText = "Enter Phone Number",
    this.countryCode = "+91",
    this.isRequired = true,
    this.maxLength = 10,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Row(
            children: [
              PlusJakartaText(
                text: label,
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize16(context),
                fontWeight: FontWeight.w800,
              ),
              if (isRequired)
                PlusJakartaText(
                  text: " *",
                  color: myColors?.error,
                  fontSize: ResponsiveFontSizes.fontSize16(context),
                  fontWeight: FontWeight.w800,
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: errorText != null
                  ? myColors!.error!
                  : myColors?.borderGray ?? Colors.black12,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      myColors!.primary,
                      ?myColors.primaryLight?.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(9),
                    bottomLeft: Radius.circular(9),
                  ),
                ),
                child: PlusJakartaText(
                  text: countryCode,
                  color: Colors.white,
                  fontSize: ResponsiveFontSizes.fontSize16(context),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.phone,
                  onChanged: onChanged,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(maxLength),
                  ],
                  style: GoogleFonts.plusJakartaSans(
                    color: myColors?.txt,
                    fontSize: ResponsiveFontSizes.fontSize15(context),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: hintText,
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: myColors?.lightGray,
                      fontSize: ResponsiveFontSizes.fontSize15(context),
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          PlusJakartaText(
            text: errorText,
            color: myColors?.error,
            fontSize: ResponsiveFontSizes.fontSize12(context),
            fontWeight: FontWeight.w500,
          ),
        ],
      ],
    );
  }
}
