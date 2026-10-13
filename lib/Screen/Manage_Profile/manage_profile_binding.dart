import 'package:chotekisan_delivery_app/Screen/Manage_Profile/manage_profile_controller.dart';
import 'package:get/get.dart';

class ManageProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ManageProfileController>(ManageProfileController());
  }
}
