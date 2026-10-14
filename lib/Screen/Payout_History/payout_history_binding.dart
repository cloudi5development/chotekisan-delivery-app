import 'package:chotekisan_delivery_app/Screen/Payout_History/payout_history_controller.dart';
import 'package:get/get.dart';

class PayoutHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PayoutHistoryController>(PayoutHistoryController());
  }
}

