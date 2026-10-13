import 'package:chotekisan_delivery_app/Screen/Notifications/notifications_controller.dart';
import 'package:get/get.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationsController>(NotificationsController());
  }
}
