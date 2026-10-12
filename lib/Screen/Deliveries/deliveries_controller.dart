import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/Screen/Home/home_controller.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class DeliveriesController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  // 0 = Available, 1 = Accepted, 2 = Picked Up, 3 = Delivered
  RxInt selectedTab = 0.obs;
  final List<String> tabs = ["Available", "Accepted", "Picked Up", "Delivered"];

  RxList<OrderModel> deliveredOrders = <OrderModel>[].obs;

  List<OrderModel> get availableOrders => homeController.availableOrders;

  List<OrderModel> get acceptedOrders => homeController.currentDeliveries
      .where((order) => !order.isPickedUp.value)
      .toList();

  List<OrderModel> get pickedUpOrders => homeController.currentDeliveries
      .where((order) => order.isPickedUp.value)
      .toList();

  List<OrderModel> ordersFor(int tab) {
    switch (tab) {
      case 0:
        return availableOrders;
      case 1:
        return acceptedOrders;
      case 2:
        return pickedUpOrders;
      default:
        return deliveredOrders;
    }
  }

  String countText(int tab) => ordersFor(tab).length.toString().padLeft(2, '0');

  @override
  void onInit() {
    super.onInit();
    loadDeliveredOrders();
  }

  void loadDeliveredOrders() {
    // TODO: replace sample orders with the delivered orders api.
    deliveredOrders.assignAll([
      for (int i = 1; i <= 4; i++)
        OrderModel(
          orderId: "#ORD0$i",
          distance: "1.8 km",
          amount: "79",
          paymentType: i.isOdd ? "COD" : "Online",
          pickupName: "Main-Hub Gandhipuram",
          pickupAddress:
              "Aavin Illam, 3A, Pasumpon Muthuramalingam Salai, Coimbatore, 641035.",
          customerName: "Customer Name",
          customerMobile: "",
          dropAddress:
              "Plot No. 12, Lakshmi Garden, Saravanampatti, Coimbatore, 641035.",
          orderType: i == 1 ? "Doorstep" : null,
          customerNote: i == 1
              ? "Please leave the order at the main door. Ring the bell once you place it."
              : null,
          acceptedOn: "05 June 2026, 02:39 PM",
          pickedUpOn: "05 June 2026, 02:59 PM",
          startedOn: "05 June 2026, 03:11 PM",
          deliveredOn: "05 June 2026, 03:33 PM",
        )..isPickedUp.value = true,
    ]);
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void onViewDetails(OrderModel order) {
    Get.toNamed(AppRoutes.deliveryDetails, arguments: order);
  }

}
