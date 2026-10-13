import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';

/// Shows the Log Out confirmation popup. Resolves to `true` when Logout is
/// tapped.
Future<bool> showLogoutDialog(BuildContext context) async {
  MyColors? myColors = Theme.of(context).extension<MyColors>();
  const Color red = Color(0xffE02424);
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 76,
              width: 76,
              decoration: BoxDecoration(
                color: red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout_rounded, color: red, size: 32),
            ),

            const SizedBox(height: 14),
            OnestText(
              text: "Log Out",
              color: red,
              fontSize: ResponsiveFontSizes.fontSize20(context),
              fontWeight: FontWeight.w700,
            ),

            const SizedBox(height: 4),
            OnestText(
              text: "Are you sure you want to logout?",
              color: myColors?.primaryText,
              fontSize: ResponsiveFontSizes.fontSize15(context),
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(ctx).pop(false),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE4E7EC)),
                      ),
                      child: OnestText(
                        text: "Cancel",
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize16(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(ctx).pop(true),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: OnestText(
                        text: "Logout",
                        color: Colors.white,
                        fontSize: ResponsiveFontSizes.fontSize16(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return result ?? false;
}
