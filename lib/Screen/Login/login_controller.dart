import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController mobileController = TextEditingController();

  RxString mobile = "".obs;
  RxnString errorText = RxnString();

  // 0 = In-House, 1 = Freelance
  int deliveryType = 0;

  bool get isValid => mobile.value.length == 10;

  @override
  void onInit() {
    super.onInit();
    deliveryType = Get.arguments is int ? Get.arguments : 0;
  }

  void onMobileChanged(String value) {
    mobile.value = value;
    errorText.value = null;
  }

  void sendOtp() {
    if (!isValid) {
      errorText.value = "Please enter a valid 10-digit mobile number.";
      return;
    }
    // TODO: call send OTP api here. When the number is not registered set
    // errorText.value =
    //     "Your number is not registered as a delivery partner. Please contact support.";
    Get.toNamed(
      AppRoutes.otp,
      arguments: {"mobile": mobile.value, "type": deliveryType},
    );
  }

  @override
  void onClose() {
    mobileController.dispose();
    super.onClose();
  }
}
