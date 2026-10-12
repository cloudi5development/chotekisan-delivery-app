import 'package:chotekisan_delivery_app/Screen/Basic_Information/basic_information_controller.dart';
import 'package:get/get.dart';

class BasicInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BasicInformationController>(BasicInformationController());
  }
}
