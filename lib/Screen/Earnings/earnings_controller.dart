import 'package:chotekisan_delivery_app/Model/earning_model.dart';
import 'package:chotekisan_delivery_app/common/earning_info_sheet.dart';
import 'package:chotekisan_delivery_app/common/earnings_filter_sheet.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningsController extends GetxController {
  final List<String> tabs = ["Daily", "Weekly", "Monthly"];

  // 0 = Daily, 1 = Weekly, 2 = Monthly
  RxInt selectedTab = 0.obs;

  // 0 = current day / week / month, -1 = the one before, and so on
  RxInt periodOffset = 0.obs;

  // Earnings breakdown under the green card
  RxBool isExpanded = false.obs;
  RxBool showAllTransactions = false.obs;

  // Date range filter. The draft dates are the ones being picked in the
  // sheet, they only take effect on Apply.
  RxBool isFiltered = false.obs;
  Rxn<DateTime> draftFrom = Rxn<DateTime>();
  Rxn<DateTime> draftTo = Rxn<DateTime>();
  DateTime? _appliedFrom;
  DateTime? _appliedTo;

  // TODO: load from api.
  RxInt payoutDaysLeft = 5.obs;

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  // Sample data so every state of the screen can be seen: today has no
  // transactions, earlier days do. TODO: replace with the earnings api.
  DayEarningModel _dayFor(DateTime date) {
    final count = date == _today ? 0 : 3 + (date.day % 4);
    return DayEarningModel(
      date: date,
      onlineMinutes: count == 0 ? 0 : 336,
      transactions: [
        for (int i = 0; i < count; i++)
          TransactionModel(
            orderId: "#ORD${(i + 1).toString().padLeft(3, '0')}",
            dateTime: date.add(Duration(hours: 10, minutes: 45 * i)),
            orderValue: 149,
            cashCollected: 145,
            orderEarnings: i.isOdd ? 54 : 79,
            tips: i.isOdd ? 25 : 0,
          ),
      ],
    );
  }

  // First day of the period being shown
  DateTime get _periodStart {
    if (isFiltered.value) return _appliedFrom!;
    switch (selectedTab.value) {
      case 0:
        return _today.add(Duration(days: periodOffset.value));
      case 1:
        return _today
            .subtract(Duration(days: _today.weekday - 1))
            .add(Duration(days: 7 * periodOffset.value));
      default:
        return DateTime(_today.year, _today.month + periodOffset.value, 1);
    }
  }

  DateTime get _periodEnd {
    final DateTime end;
    if (isFiltered.value) {
      end = _appliedTo!;
    } else {
      final start = _periodStart;
      switch (selectedTab.value) {
        case 0:
          end = start;
        case 1:
          end = DateTime(start.year, start.month, start.day + 6);
        default:
          end = DateTime(start.year, start.month + 1, 0);
      }
    }
    return end.isAfter(_today) ? _today : end;
  }

  // Days of the period, newest first
  List<DayEarningModel> get periodDays {
    final start = _periodStart;
    final end = _periodEnd;
    return [
      for (
        DateTime day = end;
        !day.isBefore(start);
        day = DateTime(day.year, day.month, day.day - 1)
      )
        _dayFor(day),
    ];
  }

  List<TransactionModel> get transactions => [
    for (final day in periodDays) ...day.transactions.reversed,
  ];

  int get totalEarnings =>
      periodDays.fold(0, (total, day) => total + day.amount);
  int get orderEarnings =>
      transactions.fold(0, (total, item) => total + item.orderEarnings);
  int get incentives =>
      transactions.fold(0, (total, item) => total + item.incentives);
  int get tips => transactions.fold(0, (total, item) => total + item.tips);
  int get bonus => transactions.fold(0, (total, item) => total + item.bonus);

  // e.g. `7h 25m`
  String get onlineHoursText {
    final minutes = periodDays.fold(
      0,
      (total, day) => total + day.onlineMinutes,
    );
    return "${minutes ~/ 60}h ${minutes % 60}m";
  }

  String get ordersCompletedText =>
      transactions.length.toString().padLeft(2, '0');

  // Daily and filtered views list the orders, weekly and monthly list days
  bool get showsTransactions => isFiltered.value || selectedTab.value == 0;

  bool get canGoNext => !isFiltered.value && periodOffset.value < 0;
  bool get canGoPrevious => !isFiltered.value;

  String _ordinal(int day) {
    if (day >= 11 && day <= 13) return "${day}th";
    switch (day % 10) {
      case 1:
        return "${day}st";
      case 2:
        return "${day}nd";
      case 3:
        return "${day}rd";
      default:
        return "${day}th";
    }
  }

  // Title on the green card
  String get periodTitle {
    final start = _periodStart;
    if (isFiltered.value) {
      final end = _appliedTo!;
      return "${shortMonth(start.month)} ${start.day.toString().padLeft(2, '0')} - "
          "${shortMonth(end.month)} ${end.day.toString().padLeft(2, '0')}, ${end.year} Earnings";
    }
    switch (selectedTab.value) {
      case 0:
        if (periodOffset.value == 0) return "Today’s Earnings";
        return "${_ordinal(start.day)} ${fullMonth(start.month)}, ${start.year}";
      case 1:
        return "Week ${((start.day - 1) ~/ 7) + 1}, ${shortMonth(start.month)}, ${start.year}";
      default:
        return "${shortMonth(start.month)} ${start.year}";
    }
  }

  String get summaryTitle {
    if (isFiltered.value) return "SUMMARY";
    return ["DAILY SUMMARY", "WEEKLY SUMMARY", "MONTHLY SUMMARY"][selectedTab
        .value];
  }

  String get sectionTitle {
    if (isFiltered.value) return "Your Transaction";
    return ["Recent Transaction", "Weekly Earnings", "Monthly Earnings"][selectedTab
        .value];
  }

  String get emptyTitle =>
      !isFiltered.value && selectedTab.value == 0 && periodOffset.value == 0
      ? "No transaction yet today!"
      : "No transaction found!";

  // Header of the day screen, e.g. `Week 2, Jun Earnings`
  String get dayScreenTitle {
    final start = _periodStart;
    if (selectedTab.value == 1) {
      return "Week ${((start.day - 1) ~/ 7) + 1}, ${shortMonth(start.month)} Earnings";
    }
    return "${shortMonth(start.month)} ${start.year} Earnings";
  }

  void selectTab(int index) {
    selectedTab.value = index;
    isFiltered.value = false;
    periodOffset.value = 0;
    isExpanded.value = false;
    showAllTransactions.value = false;
  }

  void onPrevious() {
    if (!canGoPrevious) return;
    periodOffset.value--;
    showAllTransactions.value = false;
  }

  void onNext() {
    if (!canGoNext) return;
    periodOffset.value++;
    showAllTransactions.value = false;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void onViewAllTransactions() {
    showAllTransactions.value = true;
  }

  void onTransactionTap(TransactionModel transaction) {
    Get.bottomSheet(
      EarningInfoSheet(transaction: transaction),
      isScrollControlled: true,
    );
  }

  void onDayTap(DayEarningModel day) {
    Get.toNamed(
      AppRoutes.dayEarnings,
      arguments: {"day": day, "title": dayScreenTitle},
    );
  }

  // Filter sheet
  void openFilter() {
    draftFrom.value = isFiltered.value ? _appliedFrom : null;
    draftTo.value = isFiltered.value ? _appliedTo : null;
    Get.bottomSheet(const EarningsFilterSheet(), isScrollControlled: true);
  }

  bool get canApplyFilter => draftFrom.value != null && draftTo.value != null;

  // e.g. `01/05/2026`, or the placeholder when no date is picked
  String filterDateText(DateTime? date) {
    if (date == null) return "dd/mm/yyyy";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Future<void> pickFilterDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: (isFrom ? draftFrom.value : draftTo.value) ?? _today,
      firstDate: DateTime(2024),
      lastDate: _today,
    );
    if (picked == null) return;
    if (isFrom) {
      draftFrom.value = picked;
    } else {
      draftTo.value = picked;
    }
  }

  void applyFilter() {
    if (!canApplyFilter) return;
    // Accept the dates in either order
    final from = draftFrom.value!;
    final to = draftTo.value!;
    _appliedFrom = from.isAfter(to) ? to : from;
    _appliedTo = from.isAfter(to) ? from : to;
    isFiltered.value = true;
    // Rebuilds the screen when a filter is replaced by another one
    isFiltered.refresh();
    isExpanded.value = false;
    showAllTransactions.value = false;
    Get.back();
  }

  void clearFilter() {
    draftFrom.value = null;
    draftTo.value = null;
    isFiltered.value = false;
    showAllTransactions.value = false;
    Get.back();
  }
}
