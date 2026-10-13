const List<String> _weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
const List<String> _months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];
const List<String> _fullMonths = [
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

/// Short month name, e.g. `Jun`.
String shortMonth(int month) => _months[month - 1];

/// Full month name, e.g. `June`.
String fullMonth(int month) => _fullMonths[month - 1];

/// Formats an amount with Indian comma grouping, e.g. `3,711` or `1,25,000`.
String formatAmount(int amount) {
  final digits = amount.abs().toString();
  if (digits.length <= 3) return digits;
  final lastThree = digits.substring(digits.length - 3);
  String rest = digits.substring(0, digits.length - 3);
  final groups = <String>[];
  while (rest.length > 2) {
    groups.insert(0, rest.substring(rest.length - 2));
    rest = rest.substring(0, rest.length - 2);
  }
  if (rest.isNotEmpty) groups.insert(0, rest);
  return "${groups.join(",")},$lastThree";
}

/// One completed order and what the rider earned from it.
class TransactionModel {
  final String orderId;
  final DateTime dateTime;
  final int orderValue;
  final int cashCollected;
  final int orderEarnings;
  final int incentives;
  final int tips;
  final int bonus;

  TransactionModel({
    required this.orderId,
    required this.dateTime,
    required this.orderValue,
    required this.cashCollected,
    required this.orderEarnings,
    this.incentives = 0,
    this.tips = 0,
    this.bonus = 0,
  });

  int get earned => orderEarnings + incentives + tips + bonus;

  // e.g. `10:00 AM`
  String get timeText {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour >= 12 ? "PM" : "AM";
    return "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period";
  }

  // e.g. `May 01, 2026 - 10:00 AM`
  String get dateTimeText =>
      "${shortMonth(dateTime.month)} ${dateTime.day.toString().padLeft(2, '0')}, ${dateTime.year} - $timeText";

  // e.g. `05 June 2026, 02:39 PM`
  String get fullDateText =>
      "${dateTime.day.toString().padLeft(2, '0')} ${fullMonth(dateTime.month)} ${dateTime.year}, $timeText";
}

/// One day's earnings, shown as a row in the weekly and monthly lists.
class DayEarningModel {
  final DateTime date;
  final int onlineMinutes;
  final List<TransactionModel> transactions;

  DayEarningModel({
    required this.date,
    required this.onlineMinutes,
    required this.transactions,
  });

  int get amount =>
      transactions.fold(0, (total, transaction) => total + transaction.earned);

  // e.g. `Sat, 13 Jun`
  String get label =>
      "${_weekDays[date.weekday - 1]}, ${date.day.toString().padLeft(2, '0')} ${shortMonth(date.month)}";

  // e.g. `05h 36m`
  String get onlineHoursText =>
      "${(onlineMinutes ~/ 60).toString().padLeft(2, '0')}h ${(onlineMinutes % 60).toString().padLeft(2, '0')}m";
}
