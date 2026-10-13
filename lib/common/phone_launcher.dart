import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the phone's dialer with [number] filled in. The rider still presses
/// the call button themselves. Returns false when the dialer could not open.
Future<bool> callPhoneNumber(String number) async {
  final digits = number.trim();
  if (digits.isEmpty) return false;
  try {
    return await launchUrl(Uri(scheme: "tel", path: digits));
  } catch (e) {
    debugPrint("Open dialer failed: $e");
    return false;
  }
}
