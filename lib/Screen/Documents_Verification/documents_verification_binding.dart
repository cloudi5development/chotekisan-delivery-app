import 'package:chotekisan_delivery_app/Screen/Documents_Verification/documents_verification_controller.dart';
import 'package:get/get.dart';

class DocumentsVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DocumentsVerificationController>(DocumentsVerificationController());
  }
}
