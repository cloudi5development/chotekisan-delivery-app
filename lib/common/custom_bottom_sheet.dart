import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

/// Bottom sheet with a close button above a rounded white card.
///
/// The card sizes itself to [child] and scrolls when the content is taller
/// than the available space (small screens, large font scale, or the
/// keyboard being open), so it never overflows.
class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  const CustomBottomSheet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();

    return Padding(
      // Lift the sheet above the keyboard (e.g. the OTP step).
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: myColors?.white,
                ),
                child: const Icon(Icons.close, size: 16),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: myColors?.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
