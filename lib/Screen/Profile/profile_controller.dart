import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = "YOGESH S".obs;
  final RxString partnerId = "DPID001".obs;
  final RxDouble rating = 4.8.obs;
  final RxString partnerType = "In-house Partner".obs;
  final RxBool isOnline = true.obs;

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }
}
