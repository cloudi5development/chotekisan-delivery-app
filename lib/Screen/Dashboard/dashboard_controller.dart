import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  /// Selected bottom-navigation tab.
  final RxInt tabIndex = 0.obs;

  /// The nav bar slides away while the user scrolls down and comes back on
  /// the way up.
  final RxBool isNavBarVisible = true.obs;

  void changeTabIndex(int index) {
    if (tabIndex.value == index) return;
    tabIndex.value = index;
    isNavBarVisible.value = true;
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          isNavBarVisible.value = true;
        case ScrollDirection.reverse:
          isNavBarVisible.value = false;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }
}
