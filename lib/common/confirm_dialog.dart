import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';


/// Shows a Yes / No confirmation popup. Resolves to `true` when Yes is tapped.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  VoidCallback? no,
  VoidCallback? yes,
}) async {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  MyColors? myColors = Theme.of(context).extension<MyColors>();
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlusJakartaText(
              text: title,
              color: myColors?.txt,
              fontSize: ResponsiveFontSizes.fontSize17(context),
              fontWeight: FontWeight.w800,
            ),

            const SizedBox(height: 12),
            PlusJakartaText(
              text: message,
              color: myColors?.primaryText,
              fontSize: ResponsiveFontSizes.fontSize15(context),
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 34),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "No",
                    height: 44,
                    width: width * 0.4,
                    textcolor: myColors!.primary,
                    bgcolor: myColors.bg1,
                    onPressed: no,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomButton(
                    text: "Yes",
                    height: 44,
                    width: width * 0.4,
                    textcolor: myColors.white!,
                    gradient: [myColors.primary, myColors.primaryLight!],
                    onPressed: yes,
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
