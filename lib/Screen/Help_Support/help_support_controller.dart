import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class HelpSupportController extends GetxController {
  void chatWithSupport() {
    Get.toNamed(AppRoutes.messageCentre);
  }

  void callSupport() {
    // TODO: dial the support number with url_launcher.
  }

  void emailSupport() {
    // TODO: open the mail composer with url_launcher.
  }

  void openFaqs() {
    Get.toNamed(AppRoutes.faqs);
  }
}
