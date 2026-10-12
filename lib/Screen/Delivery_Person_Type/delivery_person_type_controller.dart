import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class DeliveryPersonTypeController extends GetxController {
  // 0 = In-House, 1 = Freelance
  RxInt selectedType = 0.obs;

  void selectType(int type) {
    selectedType.value = type;
  }

  void onContinue() {
    Get.toNamed(AppRoutes.login, arguments: selectedType.value);
  }
}
