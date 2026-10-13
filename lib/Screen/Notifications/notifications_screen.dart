import 'package:chotekisan_delivery_app/Screen/Notifications/notifications_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
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

            // Filter chips
            SizedBox(
              height: 60,
              child: Obx(
                () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                  itemCount: controller.filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final filter = controller.filters[index];
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
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Grouped notifications
            Expanded(
              child: Obx(() {
                final grouped = controller.groupedNotifications;
                if (grouped.isEmpty) {
                  return Center(
                    child: OnestText(
                      text: "No notifications yet",
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize17(context),
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
                          fontWeight: FontWeight.w700,
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
                                _NotificationTile(
                                  notification: entry.value[i],
                                ),
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

  IconData get _icon {
    switch (notification.category) {
      case NotificationCategory.orders:
        return Icons.inventory_2_rounded;
      case NotificationCategory.earnings:
        return Icons.shopping_bag_rounded;
      case NotificationCategory.incentives:
        return Icons.military_tech_rounded;
      case NotificationCategory.general:
        return Icons.notifications_rounded;
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
            child: Icon(_icon, size: 21, color: const Color(0xffF59E0B)),
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
                        fontSize: ResponsiveFontSizes.fontSize17(context),
                        fontWeight: FontWeight.w700,
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
                  fontSize: ResponsiveFontSizes.fontSize15(context),
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
