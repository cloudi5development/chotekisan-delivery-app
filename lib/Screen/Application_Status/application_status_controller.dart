import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class ApplicationStatusController extends GetxController {
  // false = Successfully Submitted, true = Successfully Verified
  RxBool isVerified = false.obs;

  @override
  void onReady() {
    super.onReady();
    checkVerification();
  }

  Future<void> checkVerification() async {
    // TODO: replace this placeholder delay with the application status api.
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    isVerified.value = true;
  }

  void onLogin() {
    Get.offAllNamed(AppRoutes.dashboard);
  }
}
