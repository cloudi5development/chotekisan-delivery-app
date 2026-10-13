import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReferEarnController extends GetxController {
  // Sample data. TODO: load referral details from api.
  final RxString referralCode = "DPID001".obs;
  final RxInt totalReferrals = 12.obs;
  final RxInt totalEarned = 750.obs;

  Future<void> copyCode(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: referralCode.value));
    if (context.mounted) {
      showSuccessSnackBar("Referral code copied", context);
    }
  }

  void shareViaWhatsapp() {
    // TODO: share the referral code via whatsapp.
  }

  void shareViaSms() {
    // TODO: share the referral code via sms.
  }

  void shareLink() {
    // TODO: share the referral link.
  }

  void shareMore() {
    // TODO: open the system share sheet.
  }
}
