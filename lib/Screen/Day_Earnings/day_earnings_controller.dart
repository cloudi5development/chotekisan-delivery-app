import 'package:chotekisan_delivery_app/Model/earning_model.dart';
import 'package:chotekisan_delivery_app/common/earning_info_sheet.dart';
import 'package:get/get.dart';

class DayEarningsController extends GetxController {
  // TODO: load the day's transactions from api.
  late final DayEarningModel day;
  String title = "";

  @override
  void onInit() {
    super.onInit();
    day = Get.arguments["day"] as DayEarningModel;
    title = Get.arguments["title"]?.toString() ?? "Earnings";
  }

  void onTransactionTap(TransactionModel transaction) {
    Get.bottomSheet(
      EarningInfoSheet(transaction: transaction),
      isScrollControlled: true,
    );
  }
}
