import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? bgcolor;
  final Color textcolor;
  final double height;
  final double width;
  final List<Color>? gradient;

  /// Svg asset path, tinted only when [iconColor] is given.
  final String? svgIcon;

  /// Any widget (an [Icon], [Image], ...) shown instead of [svgIcon].
  final Widget? icon;

  /// Size used for [svgIcon]. Ignored when [icon] is provided.
  final double iconSize;

  /// Optional tint for [svgIcon].
  final Color? iconColor;

  /// Whether the icon sits before or after the label.
  final bool iconLeading;

  /// Corner radius of the button.
  final double borderRadius;

  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.svgIcon,
    this.iconSize = 18,
    this.iconColor,
    this.iconLeading = false,
    this.borderRadius = 7,
    this.gradient,
    required this.height,
    required this.width,
    this.bgcolor,
    required this.textcolor,
  }) : assert(
         (bgcolor == null) != (gradient == null),
         'Provide either bgcolor or gradient, not both.',
       ),
       assert(
         icon == null || svgIcon == null,
         'Provide either icon or svgIcon, not both.',
       );

  @override
  Widget build(BuildContext context) {
    final Widget? iconWidget =
        icon ??
        (svgIcon == null
            ? null
            : SvgPicture.asset(
                svgIcon!,
                height: iconSize,
                width: iconSize,
                colorFilter: iconColor == null
                    ? null
                    : ColorFilter.mode(iconColor!, BlendMode.srcIn),
              ));
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: bgcolor,
          gradient: gradient == null
              ? null
              : LinearGradient(
                  colors: gradient!,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconLeading && iconWidget != null) ...[
              iconWidget,
              const SizedBox(width: 4),
            ],
            PlusJakartaText(
              text: text,
              color: textcolor,
              fontSize: ResponsiveFontSizes.fontSize16(context),
              fontWeight: FontWeight.w700,
            ),
            if (!iconLeading && iconWidget != null) ...[
              const SizedBox(width: 4),
              iconWidget,
            ],
          ],
        ),
      ),
    );
  }
}
