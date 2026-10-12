import 'package:get/get.dart';

class OrderModel {
  final String orderId;
  final String distance;
  final String amount;
  final String paymentType;
  final String pickupName;
  final String pickupAddress;
  final String customerName;
  final String customerMobile;
  final String dropAddress;

  // Delivery details
  final String orderAmount;
  final String collectAmount;
  final String? orderType;
  final String? customerNote;
  final String? capturedPhoto;

  // Timeline
  String? acceptedOn;
  String? pickedUpOn;
  String? startedOn;
  String? deliveredOn;

  // false = waiting at pickup, true = picked up and ready to deliver
  final RxBool isPickedUp = false.obs;

  bool get isCod => paymentType.toUpperCase() == "COD";

  OrderModel({
    required this.orderId,
    required this.distance,
    required this.amount,
    required this.paymentType,
    required this.pickupName,
    required this.pickupAddress,
    required this.customerName,
    required this.customerMobile,
    required this.dropAddress,
    this.orderAmount = "000",
    this.collectAmount = "149",
    this.orderType,
    this.customerNote,
    this.capturedPhoto,
    this.acceptedOn,
    this.pickedUpOn,
    this.startedOn,
    this.deliveredOn,
  });

  /// Formats a date like `05 June 2026, 02:39 PM`.
  static String formatDateTime(DateTime date) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour >= 12 ? "PM" : "AM";
    return "${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}, "
        "${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period";
  }
}
