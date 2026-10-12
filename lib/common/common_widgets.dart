import 'dart:async';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String dismiss = "Dismiss";

/// Paints a vertical dashed line down the centre of its box.
class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;
  final double dashGap;

  const DashedLinePainter({
    required this.color,
    this.dashHeight = 5,
    this.dashGap = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    double y = 0;
    while (y < size.height) {
      final end = (y + dashHeight).clamp(0, size.height).toDouble();
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, end),
        paint,
      );
      y += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}

class InfoNoteBox extends StatelessWidget {
  final String text;

  /// Smaller grey line under [text].
  final String? subText;

  /// Defaults to the orange note style when the colours are not given.
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const InfoNoteBox({
    super.key,
    required this.text,
    this.subText,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(0xffF8EEE5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            size: 16,
            color: iconColor ?? myColors?.primary,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnestText(
                  text: text,
                  color: textColor ?? myColors?.primary,
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.35,
                ),
                if (subText != null)
                  OnestText(
                    text: subText,
                    color: myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize13(context),
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.5,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showSuccessSnackBar(String message, BuildContext context) {
  // `Get.overlayContext` hands back a context *inside* the overlay, where
  // `Overlay.of` finds no `OverlayState` ancestor. Fall back to the
  // navigator's own overlay so either kind of context works.
  final overlay =
      Overlay.maybeOf(context) ??
      Navigator.maybeOf(context, rootNavigator: true)?.overlay;
  if (overlay == null) return;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 16,
        left: 16,
        right: 16,
        child: IgnorePointer(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 32,
              ),
              child: IntrinsicWidth(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AssetSvgPath.tickIcon,
                          width: 18,
                          height: 18,
                        ),

                        const SizedBox(width: 6),

                        Flexible(
                          child: Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Timer(const Duration(seconds: 2), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}

void showErrorSnackBar(String message, BuildContext context) {
  final overlay = Overlay.of(context);

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 16,
        left: 16,
        right: 16,
        child: IgnorePointer(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 32,
              ),
              child: IntrinsicWidth(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AssetSvgPath.tickIcon,
                          width: 18,
                          height: 18,
                        ),

                        const SizedBox(width: 6),

                        Flexible(
                          child: Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);

  Timer(const Duration(seconds: 2), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}

void showMessageSnackBar(String message, BuildContext context) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Flexible(child: Text(message))],
    ),
    backgroundColor: Color(0XFF868686),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Adjust the radius value here
    ),
    duration: const Duration(seconds: 2),
  );

  final messenger = ScaffoldMessenger.of(context);

  messenger.showSnackBar(snackBar);

  Future.delayed(const Duration(seconds: 2), () {
    if (messenger.mounted) {
      messenger.hideCurrentSnackBar();
    }
  });
}
