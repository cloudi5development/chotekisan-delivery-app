import 'package:chotekisan_delivery_app/Screen/Notifications/notifications_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(title: "Notifications", showBack: true),

            // Filter chips – filters list is static, no Obx needed here;
            // selectedFilter.value is read inside itemBuilder via a nested Obx.
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                itemCount: controller.filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final filter = controller.filters[index];
                  return Obx(() {
                    final isSelected =
                        controller.selectedFilter.value == filter;
                    return GestureDetector(
                      onTap: () => controller.selectedFilter.value = filter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xffEEF8F0)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? myColors?.green ?? Colors.green
                                : const Color(0xffE4E7EC),
                          ),
                        ),
                        child: OnestText(
                          text: filter,
                          color: isSelected
                              ? myColors?.green
                              : myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize16(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            // Grouped notifications – directly read both Rx observables inside
            // Obx so GetX can track reactivity properly.
            Expanded(
              child: Obx(() {
                // Access both observables so GetX registers them as dependencies.
                final selectedFilter = controller.selectedFilter.value;
                final allNotifications = controller.notifications;

                final filtered = allNotifications.where((n) {
                  switch (selectedFilter) {
                    case "Orders":
                      return n.category == NotificationCategory.orders;
                    case "Earnings":
                      return n.category == NotificationCategory.earnings;
                    case "Incentives":
                      return n.category == NotificationCategory.incentives;
                    default:
                      return true;
                  }
                });

                final grouped = <String, List<AppNotification>>{};
                for (final notification in filtered) {
                  grouped
                      .putIfAbsent(notification.dateGroup, () => [])
                      .add(notification);
                }

                if (grouped.isEmpty) {
                  return Center(
                    child: OnestText(
                      text: "No notifications yet",
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final entry in grouped.entries) ...[
                        OnestText(
                          text: entry.key,
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0; i < entry.value.length; i++) ...[
                                if (i > 0)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(0xffF0F1F3),
                                    ),
                                  ),
                                _NotificationTile(notification: entry.value[i]),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;

  const _NotificationTile({required this.notification});

  String get _svgPath {
    switch (notification.category) {
      case NotificationCategory.orders:
        return AssetSvgPath.orderDelivered;
      case NotificationCategory.earnings:
        return AssetSvgPath.paymentReceived;
      case NotificationCategory.incentives:
        return AssetSvgPath.incentiveUnlocked;
      case NotificationCategory.general:
        return AssetSvgPath.notificationIconColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              color: Color(0xffF4F5F7),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(_svgPath, width: 22, height: 22),
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OnestText(
                        text: notification.title,
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize16(context),
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(width: 8),
                    if (notification.isUnread) ...[
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: myColors?.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    OnestText(
                      text: notification.time,
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize14(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                const SizedBox(height: 3),
                OnestText(
                  text: notification.description,
                  color: myColors?.primaryText,
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
