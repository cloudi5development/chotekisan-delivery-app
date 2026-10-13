import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_controller.dart';
import 'package:chotekisan_delivery_app/Screen/Deliveries/deliveries_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Earnings/earnings_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Home/home_screen.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        // Back on any other tab returns to Home instead of leaving the app.
        canPop: controller.tabIndex.value == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) controller.changeTabIndex(0);
        },
        child: Scaffold(
          backgroundColor: Color(0xffF8F9FB),
          extendBody: true,
          body: NotificationListener<ScrollNotification>(
            onNotification: controller.handleScrollNotification,
            child: Obx(
              () => IndexedStack(
                index: controller.tabIndex.value,
                children: const [
                  HomeScreen(),
                  DeliveriesScreen(),
                  EarningsScreen(),
                  _ComingSoonTab(title: "Profile"),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const _DashboardNavBar(),
        ),
      ),
    );
  }
}

/// Full-width white bar that slides out of the way while scrolling down.
class _DashboardNavBar extends GetView<DashboardController> {
  const _DashboardNavBar();

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Obx(
      () => AnimatedSlide(
        offset: controller.isNavBarVisible.value
            ? Offset.zero
            : const Offset(0, 1.2),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeInOutCubic,
        child: IgnorePointer(
          ignoring: !controller.isNavBarVisible.value,
          child: Container(
            decoration: BoxDecoration(
              color: myColors?.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 66,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Obx(
                    () => Row(
                      children: [
                        _NavItem(
                          index: 0,
                          label: "Home",
                          icon: AssetSvgPath.homeIcon,
                          activeIcon: AssetSvgPath.homeIconActive,
                          isActive: controller.tabIndex.value == 0,
                        ),
                        _NavItem(
                          index: 1,
                          label: "Deliveries",
                          icon: AssetSvgPath.deliveryIcon,
                          activeIcon: AssetSvgPath.deliveryIconActive,
                          isActive: controller.tabIndex.value == 1,
                        ),
                        _NavItem(
                          index: 2,
                          label: "Earnings",
                          icon: AssetSvgPath.earningsIcon,
                          activeIcon: AssetSvgPath.earningsIconActive,
                          isActive: controller.tabIndex.value == 2,
                        ),
                        _NavItem(
                          index: 3,
                          label: "Profile",
                          icon: AssetSvgPath.profileIcon,
                          activeIcon: AssetSvgPath.profileIconActive,
                          isActive: controller.tabIndex.value == 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends GetView<DashboardController> {
  final int index;
  final String label;
  final String icon;
  final String activeIcon;
  final bool isActive;

  const _NavItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTabIndex(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The icons already ship in the right colours, so they are drawn
            // untinted.
            SvgPicture.asset(
              isActive ? activeIcon : icon,
              height: 26,
              width: 26,
            ),

            const SizedBox(height: 2),

            OnestText(
              text: label,
              color: isActive ? myColors?.greenColor : myColors?.primaryText,
              fontSize: ResponsiveFontSizes.fontSize14(context),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              lineHeight: 1.35,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Stand-in for the tabs that have not been built yet.
class _ComingSoonTab extends StatelessWidget {
  final String title;

  const _ComingSoonTab({required this.title});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),
      body: Center(
        child: OnestText(
          text: title,
          color: myColors?.txt,
          fontSize: ResponsiveFontSizes.fontSize18(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
