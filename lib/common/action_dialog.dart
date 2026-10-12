import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';

/// Centre popup with an illustration, title, description and one green
/// button, e.g. "Select your zone" and "No slots selected!".
class ActionDialog extends StatelessWidget {
  final String image;

  /// Shown when [image] is missing from the assets.
  final IconData fallbackIcon;
  final String title;
  final Color? titleColor;
  final String description;
  final String buttonText;
  final bool showClose;
  final VoidCallback onPressed;

  const ActionDialog({
    super.key,
    required this.image,
    required this.fallbackIcon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.titleColor,
    this.showClose = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  image,
                  height: 104,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 104,
                    width: 104,
                    decoration: const BoxDecoration(
                      color: Color(0xffEEF8F0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(fallbackIcon, size: 52, color: myColors?.green),
                  ),
                ),

                const SizedBox(height: 24),

                OnestText(
                  textAlign: TextAlign.center,
                  text: title,
                  color: titleColor ?? myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize22(context),
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.3,
                ),
                const SizedBox(height: 6),
                OnestText(
                  textAlign: TextAlign.center,
                  text: description,
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.35,
                ),

                const SizedBox(height: 24),

                CustomButton(
                  text: buttonText,
                  height: 48,
                  width: width,
                  bgcolor: myColors?.green,
                  textcolor: Colors.white,
                  borderRadius: 16,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onPressed,
                ),
              ],
            ),
          ),

          if (showClose)
            Positioned(
              top: 14,
              right: 14,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 29,
                  width: 29,
                  decoration: const BoxDecoration(
                    color: Color(0xffEDEDED),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Color(0xff4B5563),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
