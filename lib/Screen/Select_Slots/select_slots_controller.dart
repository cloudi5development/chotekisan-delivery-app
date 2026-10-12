import 'package:chotekisan_delivery_app/Screen/Home/home_controller.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSlotsController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  // Sample data. TODO: load slots from api.
  // Each slot: [time, "1" when it is a high demand slot]
  final List<Map<String, dynamic>> slotGroups = [
    {
      "title": "MORNING",
      "range": "06:00 AM - 12:00 PM",
      "icon": Icons.wb_sunny_rounded,
      "iconColor": Color(0xffFBBF24),
      "slots": [
        ["06:00 AM - 08:00 AM", "0"],
        ["08:00 AM - 10:00 AM", "1"],
        ["10:00 AM - 12:00 PM", "0"],
      ],
    },
    {
      "title": "EVENING",
      "range": "04:00 PM - 10:00 PM",
      "icon": Icons.wb_twilight_rounded,
      "iconColor": Color(0xffF59A2E),
      "slots": [
        ["04:00 PM - 06:00 PM", "1"],
        ["06:00 PM - 08:00 PM", "1"],
        ["08:00 PM - 10:00 PM", "0"],
      ],
    },
  ];

  RxList<String> selectedSlots = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedSlots.assignAll(homeController.selectedSlots);
  }

  void toggleSlot(String slot) {
    if (selectedSlots.contains(slot)) {
      selectedSlots.remove(slot);
    } else {
      selectedSlots.add(slot);
    }
  }

  void confirmSlots(BuildContext context) {
    if (selectedSlots.isEmpty) {
      showErrorSnackBar("Please select at least one time slot", context);
      return;
    }
    // Keep the slots in the order they are listed on screen
    final ordered = [
      for (final group in slotGroups)
        for (final slot in group["slots"] as List<List<String>>)
          if (selectedSlots.contains(slot[0])) slot[0],
    ];
    homeController.confirmSlots(ordered);
    Get.back();
  }
}
