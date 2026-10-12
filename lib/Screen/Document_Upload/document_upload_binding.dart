import 'package:chotekisan_delivery_app/Screen/Document_Upload/document_upload_controller.dart';
import 'package:get/get.dart';

class DocumentUploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DocumentUploadController>(DocumentUploadController());
  }
}
