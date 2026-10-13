import 'package:chotekisan_delivery_app/Screen/Message_Centre/message_centre_controller.dart';
import 'package:get/get.dart';

class MessageCentreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MessageCentreController>(MessageCentreController());
  }
}
