import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:get/get.dart';

class DeliveryDetailsController extends GetxController {
  // TODO: load the full delivery details from api using the order id.
  late final OrderModel order;

  // Timeline rows: title and time
  List<List<String?>> get timeline => [
    ["Accepted", order.acceptedOn],
    ["Picked Up", order.pickedUpOn],
    ["Started Delivery", order.startedOn],
    ["Delivered", order.deliveredOn],
  ];

  @override
  void onInit() {
    super.onInit();
    order = Get.arguments as OrderModel;
  }
}
