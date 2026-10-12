import 'package:chotekisan_delivery_app/Screen/Home/home_controller.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectZoneController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController searchController = TextEditingController();

  // Sample data. TODO: load zones (with their map boundaries) from api.
  final List<Map<String, dynamic>> zones = [
    {
      "name": "Gandhipuram",
      "pinCode": "641012",
      "distance": "Around 7.9 Km",
      "highDemand": true,
    },
    {
      "name": "Vada Kovai",
      "pinCode": "641002",
      "distance": "Around 7.9 Km",
      "highDemand": false,
    },
    {
      "name": "RS Puram",
      "pinCode": "641002",
      "distance": "Around 8.4 Km",
      "highDemand": false,
    },
    {
      "name": "Peelamedu",
      "pinCode": "641004",
      "distance": "Around 9.2 Km",
      "highDemand": true,
    },
    {
      "name": "Saibaba Colony",
      "pinCode": "641011",
      "distance": "Around 10.1 Km",
      "highDemand": false,
    },
  ];

  RxString search = "".obs;
  RxnString selectedZone = RxnString();

  List<Map<String, dynamic>> get filteredZones {
    final query = search.value.trim().toLowerCase();
    if (query.isEmpty) return zones;
    return zones
        .where(
          (zone) =>
              (zone["name"] as String).toLowerCase().contains(query) ||
              (zone["pinCode"] as String).contains(query),
        )
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    if (homeController.assignedZone.value.isNotEmpty) {
      selectedZone.value = homeController.assignedZone.value;
    }
  }

  void confirmZone(BuildContext context) {
    if (selectedZone.value == null) {
      showErrorSnackBar("Please select a zone", context);
      return;
    }
    homeController.confirmZone(selectedZone.value!);
    Get.back();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
