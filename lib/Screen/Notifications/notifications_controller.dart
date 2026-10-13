import 'package:get/get.dart';

enum NotificationCategory { orders, earnings, incentives, general }

class AppNotification {
  final String title;
  final String description;
  final String time;

  /// Group header the notification is listed under (Today, Yesterday, ...).
  final String dateGroup;
  final NotificationCategory category;
  final bool isUnread;

  AppNotification({
    required this.title,
    required this.description,
    required this.time,
    required this.dateGroup,
    required this.category,
    this.isUnread = false,
  });
}

class NotificationsController extends GetxController {
  final List<String> filters = ["All", "Orders", "Earnings", "Incentives"];
  final RxString selectedFilter = "All".obs;

  final RxList<AppNotification> notifications = <AppNotification>[].obs;

  /// Notifications matching the selected filter, keyed by date group and
  /// keeping the original order.
  Map<String, List<AppNotification>> get groupedNotifications {
    final filtered = notifications.where((n) {
      switch (selectedFilter.value) {
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
      grouped.putIfAbsent(notification.dateGroup, () => []).add(notification);
    }
    return grouped;
  }

  @override
  void onInit() {
    super.onInit();
    // Sample data. TODO: load notifications from api.
    notifications.addAll([
      AppNotification(
        title: "Order Delivered",
        description: "Order #ORD001 has been delivered successfully",
        time: "10:30 AM",
        dateGroup: "Today",
        category: NotificationCategory.orders,
        isUnread: true,
      ),
      AppNotification(
        title: "Payment Received",
        description: "₹79 received for the order #ORD001",
        time: "10:30 AM",
        dateGroup: "Today",
        category: NotificationCategory.earnings,
        isUnread: true,
      ),
      AppNotification(
        title: "Incentives Unlocked",
        description:
            "You have unlocked a ₹50 incentive for completing 10 deliveries.",
        time: "10:30 AM",
        dateGroup: "Today",
        category: NotificationCategory.incentives,
        isUnread: true,
      ),
      AppNotification(
        title: "New Order Alert",
        description: "New order #ORD02 is available. Tap to view and accept.",
        time: "10:30 AM",
        dateGroup: "Today",
        category: NotificationCategory.orders,
        isUnread: true,
      ),
      AppNotification(
        title: "Weekly Bonus",
        description:
            "You have earned a ₹150 bonus for completing 25 deliveries.",
        time: "10:30 AM",
        dateGroup: "Yesterday",
        category: NotificationCategory.incentives,
        isUnread: true,
      ),
      AppNotification(
        title: "Maintenance Update",
        description:
            "The app will be under maintenance on 10 June, 2:00 AM - 4:00 AM.",
        time: "10:30 AM",
        dateGroup: "Yesterday",
        category: NotificationCategory.general,
      ),
      AppNotification(
        title: "Payout Processed",
        description: "Your payout of ₹1,250 has been processed successfully.",
        time: "10:30 AM",
        dateGroup: "Yesterday",
        category: NotificationCategory.earnings,
        isUnread: true,
      ),
      AppNotification(
        title: "Order Delivered",
        description: "Order #ORD001 has been delivered successfully",
        time: "10:30 AM",
        dateGroup: "07 June 2026",
        category: NotificationCategory.orders,
      ),
      AppNotification(
        title: "Maintenance Update",
        description:
            "The app will be under maintenance on 10 June, 2:00 AM - 4:00 AM.",
        time: "10:30 AM",
        dateGroup: "07 June 2026",
        category: NotificationCategory.general,
      ),
      AppNotification(
        title: "Incentives Unlocked",
        description:
            "You have unlocked a ₹50 incentive for completing 10 deliveries.",
        time: "10:30 AM",
        dateGroup: "07 June 2026",
        category: NotificationCategory.incentives,
      ),
    ]);
  }
}
