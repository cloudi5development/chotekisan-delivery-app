import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chotekisan_delivery_app/common/payout_filter_sheet.dart';

enum PayoutStatus { success, processing, rejected }

class PayoutModel {
  final String payoutId;
  final DateTime dateTime;
  final double amount;
  final PayoutStatus status;

  const PayoutModel({
    required this.payoutId,
    required this.dateTime,
    required this.amount,
    required this.status,
  });

  String get dateTimeText {
    final d = dateTime;
    final day = d.day.toString();
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    final hour = d.hour > 12 ? d.hour - 12 : (d.hour == 0 ? 12 : d.hour);
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '$day ${months[d.month]}, ${d.year} - $hour:$minute $period';
  }
}

class PayoutHistoryController extends GetxController {
  // ── Sample data (TODO: replace with API) ─────────────────────────────────
  final List<PayoutModel> _allPayouts = [
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.success,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.success,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.processing,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.success,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.processing,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.processing,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.success,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.rejected,
    ),
    PayoutModel(
      payoutId: '#PAYOUT001',
      dateTime: DateTime(2026, 6, 16, 10, 0),
      amount: 17890,
      status: PayoutStatus.success,
    ),
  ];

  // ── Filter state ──────────────────────────────────────────────────────────
  final List<String> statusOptions = ['Success', 'Processing', 'Rejected'];
  final RxString selectedStatus = ''.obs;
  final Rxn<DateTime> draftFrom = Rxn<DateTime>();
  final Rxn<DateTime> draftTo = Rxn<DateTime>();
  DateTime? _appliedFrom;
  DateTime? _appliedTo;
  String? _appliedStatus;

  final RxBool isFiltered = false.obs;

  // ── Displayed payouts ─────────────────────────────────────────────────────
  List<PayoutModel> get payouts {
    if (!isFiltered.value) return _allPayouts;
    return _allPayouts.where((p) {
      bool dateOk = true;
      if (_appliedFrom != null) {
        dateOk = !p.dateTime.isBefore(_appliedFrom!);
      }
      if (_appliedTo != null) {
        dateOk = dateOk && !p.dateTime.isAfter(_appliedTo!);
      }
      bool statusOk = true;
      if (_appliedStatus != null && _appliedStatus!.isNotEmpty) {
        statusOk = p.status.name.toLowerCase() ==
            _appliedStatus!.toLowerCase();
      }
      return dateOk && statusOk;
    }).toList();
  }

  bool get canApplyFilter =>
      draftFrom.value != null ||
      draftTo.value != null ||
      selectedStatus.value.isNotEmpty;

  void openFilter() {
    selectedStatus.value = _appliedStatus ?? '';
    draftFrom.value = _appliedFrom;
    draftTo.value = _appliedTo;
    Get.bottomSheet(const PayoutFilterSheet(), isScrollControlled: true);
  }

  void selectStatus(String status) {
    selectedStatus.value = selectedStatus.value == status ? '' : status;
  }

  String filterDateText(DateTime? date) {
    if (date == null) return 'dd/mm/yyyy';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> pickFilterDate(BuildContext context, bool isFrom) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: (isFrom ? draftFrom.value : draftTo.value) ?? today,
      firstDate: DateTime(2024),
      lastDate: today,
    );
    if (picked == null) return;
    if (isFrom) {
      draftFrom.value = picked;
    } else {
      draftTo.value = picked;
    }
  }

  void applyFilter() {
    _appliedFrom = draftFrom.value;
    _appliedTo = draftTo.value;
    _appliedStatus = selectedStatus.value;
    isFiltered.value = true;
    isFiltered.refresh();
    Get.back();
  }

  void clearFilter() {
    selectedStatus.value = '';
    draftFrom.value = null;
    draftTo.value = null;
    _appliedFrom = null;
    _appliedTo = null;
    _appliedStatus = null;
    isFiltered.value = false;
    Get.back();
  }
}

