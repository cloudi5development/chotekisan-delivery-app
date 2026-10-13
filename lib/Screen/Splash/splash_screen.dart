import 'package:chotekisan_delivery_app/Screen/Splash/splash_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: controller.logoOpacity,
              child: ScaleTransition(
                scale: controller.logoScale,
                child: Image.asset(
                  AssetImagePath.appLogo,
                  height: height * 0.2,
                  width: width * 0.4,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: controller.line1Opacity,
                  child: SlideTransition(
                    position: controller.line1Offset,
                    child: OnestText(
                      text: "Delivering Smiles,",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize24(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: controller.line2Opacity,
                  child: SlideTransition(
                    position: controller.line2Offset,
                    child: OnestText(
                      text: "Every Single Time!",
                      color: myColors?.green,
                      fontSize: ResponsiveFontSizes.fontSize24(context),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
