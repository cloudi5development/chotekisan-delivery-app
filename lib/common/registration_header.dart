import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';

class RegistrationHeader extends StatelessWidget {
  /// Current step, starting from 1.
  final int step;
  final int totalSteps;
  final VoidCallback? onBack;

  const RegistrationHeader({
    super.key,
    required this.step,
    this.totalSteps = 5,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 85,
        width: width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 40,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBack,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, size: 20, color: myColors?.txt),
                    const SizedBox(width: 6),
                    OnestText(
                      text: "Back",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize17(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 55,
              child: Center(
                child: OnestText(
                  text: "Step $step of $totalSteps",
                  color: Color(0xff4B5563),
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Positioned(
              left: 14,
              right: 14,
              bottom: 0,
              child: Row(
                children: [
                  for (int i = 1; i <= totalSteps; i++)
                    Expanded(
                      child: Container(
                        height: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 0.5),
                        decoration: BoxDecoration(
                          color: i <= step
                              ? myColors?.green
                              : Color(0xffE2E2E2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
