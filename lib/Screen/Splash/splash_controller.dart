import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;

  // Logo: pops in, holds, then fades out
  late final Animation<double> logoOpacity;
  late final Animation<double> logoScale;

  // Tagline: each line slides up and fades in after the logo is gone
  late final Animation<double> line1Opacity;
  late final Animation<Offset> line1Offset;
  late final Animation<double> line2Opacity;
  late final Animation<Offset> line2Offset;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    logoOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 15),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 35),
    ]).animate(animationController);

    logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.6,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 25,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 25),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(tween: ConstantTween(1.2), weight: 35),
    ]).animate(animationController);

    final line1Curve = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.66, 0.84, curve: Curves.easeOut),
    );
    final line2Curve = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.78, 0.96, curve: Curves.easeOut),
    );

    line1Opacity = line1Curve;
    line1Offset = Tween(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(line1Curve);
    line2Opacity = line2Curve;
    line2Offset = Tween(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(line2Curve);
  }

  @override
  void onReady() {
    super.onReady();
    _playAndNavigate();
  }

  Future<void> _playAndNavigate() async {
    try {
      await animationController.forward().orCancel;
    } on TickerCanceled {
      return;
    }
    // Let the tagline stay on screen briefly before leaving
    await Future.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;
    Get.offAllNamed(AppRoutes.deliveryPersonType);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
