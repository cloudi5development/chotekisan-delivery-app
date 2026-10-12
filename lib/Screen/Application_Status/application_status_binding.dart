import 'package:chotekisan_delivery_app/Screen/Application_Status/application_status_controller.dart';
import 'package:get/get.dart';

class ApplicationStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApplicationStatusController>(ApplicationStatusController());
  }
}
