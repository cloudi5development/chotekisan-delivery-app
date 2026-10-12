import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_controller.dart';
import 'package:chotekisan_delivery_app/Screen/Deliveries/deliveries_controller.dart';
import 'package:chotekisan_delivery_app/common/action_dialog.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // TODO: load profile, summary and orders from api. Values below are sample
  // data so the screen can be seen in every state.
  RxString userName = "Yogesh S".obs;
  RxString workingHours = "00h 00m".obs;
  RxString assignedZone = "Coimbatore North".obs;
  RxString earnings = "000".obs;
  RxString deliveries = "00".obs;
  RxString incentives = "000".obs;
  RxInt notificationCount = 1.obs;

  RxBool isOnline = false.obs;

  RxList<OrderModel> availableOrders = <OrderModel>[].obs;
  RxList<OrderModel> currentDeliveries = <OrderModel>[].obs;
  RxInt currentDeliveryIndex = 0.obs;

  // Freelancers choose their own zone and time slots before going online
  RxBool isFreelancer = false.obs;
  RxList<String> selectedSlots = <String>[].obs;

  String get slotBannerText {
    if (selectedSlots.isEmpty) return "Let’s book and go online!";
    if (selectedSlots.length == 1) return selectedSlots.first;
    return "${selectedSlots.first} +${selectedSlots.length - 1}";
  }

  @override
  void onReady() {
    super.onReady();
    _loadDeliveryType();
  }

  Future<void> _loadDeliveryType() async {
    // Saved at login: 0 = In-House, 1 = Freelance
    final prefs = await SharedPreferences.getInstance();
    isFreelancer.value = (prefs.getInt("deliveryType") ?? 0) == 1;
    if (isFreelancer.value) {
      // TODO: load the freelancer's saved zone and slots from api.
      assignedZone.value = "";
      showSelectZoneDialog();
    }
  }

  void showSelectZoneDialog() {
    Get.dialog(
      ActionDialog(
        image: AssetImagePath.selectZone,
        fallbackIcon: Icons.location_on,
        title: "Select your zone",
        description:
            "To receive orders, please select the\nzone where you want to deliver.",
        buttonText: "Select Zone",
        onPressed: () {
          Get.back();
          Get.toNamed(AppRoutes.selectZone);
        },
      ),
    );
  }

  void showNoSlotsDialog() {
    Get.dialog(
      ActionDialog(
        image: AssetImagePath.noSlots,
        fallbackIcon: Icons.event_available,
        title: "No slots selected!",
        titleColor: const Color(0xffDC2626),
        description:
            "Choose your preferred time slots\nto go online and receive orders.",
        buttonText: "Select Slot",
        showClose: true,
        onPressed: () {
          Get.back();
          Get.toNamed(AppRoutes.selectSlots);
        },
      ),
    );
  }

  void onSlotBannerTap() {
    if (assignedZone.value.isEmpty) {
      showSelectZoneDialog();
      return;
    }
    Get.toNamed(AppRoutes.selectSlots);
  }

  void onZoneTap() {
    if (isFreelancer.value) {
      Get.toNamed(AppRoutes.selectZone);
    }
  }

  void confirmZone(String zone) {
    // TODO: call save zone api here.
    assignedZone.value = zone;
  }

  void confirmSlots(List<String> slots) {
    // TODO: call save slots api here.
    selectedSlots.assignAll(slots);
    if (!isOnline.value) {
      isOnline.value = true;
      loadOrders();
    }
  }

  void toggleOnline() {
    if (!isOnline.value && isFreelancer.value) {
      if (assignedZone.value.isEmpty) {
        showSelectZoneDialog();
        return;
      }
      if (selectedSlots.isEmpty) {
        showNoSlotsDialog();
        return;
      }
    }
    isOnline.value = !isOnline.value;
    if (isOnline.value) {
      loadOrders();
    } else {
      availableOrders.clear();
    }
  }

  void loadOrders() {
    // TODO: replace sample orders with the available orders api.
    availableOrders.assignAll([
      for (int i = 1; i <= 4; i++)
        OrderModel(
          orderId: "#ORD0$i",
          distance: "1.8 km",
          amount: "79",
          paymentType: "Online",
          pickupName: "Main-Hub Gandhipuram",
          pickupAddress:
              "Aavin Illam, 3A, Pasumpon Muthuramalingam Salai, Coimbatore, 641035.",
          customerName: "Customer Name",
          customerMobile: "",
          dropAddress:
              "Plot No. 12, Lakshmi Garden, Saravanampatti, Coimbatore, 641035.",
        ),
    ]);
  }

  void acceptOrder(OrderModel order) {
    // TODO: call accept order api here.
    order.acceptedOn = OrderModel.formatDateTime(DateTime.now());
    availableOrders.remove(order);
    currentDeliveries.add(order);
  }

  void markPickedUp(OrderModel order) {
    // TODO: call picked up api here.
    order.pickedUpOn = OrderModel.formatDateTime(DateTime.now());
    order.isPickedUp.value = true;
    // The Deliveries tabs filter this list by isPickedUp
    currentDeliveries.refresh();
  }

  void callCustomer(OrderModel order) {
    // TODO: open the dialer with order.customerMobile.
  }

  void startDelivery(OrderModel order) {
    // TODO: open the delivery tracking screen.
  }

  void onDeliverySwiped(double velocity) {
    if (velocity < 0 &&
        currentDeliveryIndex.value < currentDeliveries.length - 1) {
      currentDeliveryIndex.value++;
    } else if (velocity > 0 && currentDeliveryIndex.value > 0) {
      currentDeliveryIndex.value--;
    }
  }

  void onViewAllDeliveries() {
    _openDeliveries(1);
  }

  void onViewAllOrders() {
    _openDeliveries(0);
  }

  // Switches the dashboard to the Deliveries tab.
  // tab: 0 = Available, 1 = Accepted, 2 = Picked Up, 3 = Delivered
  void _openDeliveries(int tab) {
    Get.find<DeliveriesController>().selectTab(tab);
    Get.find<DashboardController>().changeTabIndex(1);
  }
}
