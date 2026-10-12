import 'dart:async';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  String mobile = "";
  // 0 = In-House, 1 = Freelance
  int deliveryType = 0;
  RxString otp = "".obs;
  RxBool hasFocus = false.obs;
  RxnString errorText = RxnString();
  RxBool isExpired = false.obs;
  RxInt secondsLeft = 30.obs;
  RxBool isRedirecting = false.obs;

  Timer? _timer;

  String get maskedMobile {
    if (mobile.length < 4) return "+91 $mobile";
    return "+91 ${mobile.substring(0, 2)}XXXXXX${mobile.substring(mobile.length - 2)}";
  }

  String get timerText => "00:${secondsLeft.value.toString().padLeft(2, '0')}";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Map) {
      mobile = Get.arguments["mobile"]?.toString() ?? "";
      deliveryType = Get.arguments["type"] ?? 0;
    }
    otpFocusNode.addListener(() {
      hasFocus.value = otpFocusNode.hasFocus;
    });
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    secondsLeft.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  void onOtpChanged(String value) {
    otp.value = value;
    errorText.value = null;
    isExpired.value = false;
  }

  void showIncorrectOtp() {
    otpController.clear();
    otp.value = "";
    isExpired.value = false;
    errorText.value = "The OTP entered is incorrect. Please try again.";
  }

  void showExpiredOtp() {
    isExpired.value = true;
    errorText.value = "This OTP has expired. Request a new OTP to continue.";
  }

  void resendOtp() {
    // TODO: call resend OTP api here.
    otpController.clear();
    otp.value = "";
    errorText.value = null;
    isExpired.value = false;
    startTimer();
    otpFocusNode.requestFocus();
  }

  Future<void> verifyOtp() async {
    if (otp.value.length != 4) return;
    // TODO: call verify OTP api here. On failure call showIncorrectOtp() or
    // showExpiredOtp() and return.
    otpFocusNode.unfocus();
    // Home reads this to show the freelancer slot and zone options
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("deliveryType", deliveryType);
    if (deliveryType == 1) {
      // TODO: skip registration when the api says this freelancer is already
      // registered.
      Get.offAllNamed(AppRoutes.basicInformation, arguments: mobile);
      return;
    }
    isRedirecting.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    Get.offAllNamed(AppRoutes.dashboard);
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }
}
