import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeclarationController extends GetxController {
  RxBool confirmAccurate = false.obs;
  RxBool understandSuspension = false.obs;
  RxBool agreeTerms = false.obs;

  void submitApplication(BuildContext context) {
    if (!confirmAccurate.value ||
        !understandSuspension.value ||
        !agreeTerms.value) {
      showErrorSnackBar(
        "Please accept all the declarations to continue",
        context,
      );
      return;
    }
    // TODO: call submit application api here. The earlier step controllers
    // are still alive, read their values with Get.find<...Controller>().
    Get.offAllNamed(AppRoutes.applicationStatus);
  }

  void onBack() {
    Get.back();
  }
}
