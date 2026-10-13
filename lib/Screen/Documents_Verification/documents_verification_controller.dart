import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationDocument {
  final String title;
  final String updatedOn;

  /// Profile photo rows get a camera action instead of the upload one.
  final bool isPhoto;

  VerificationDocument({
    required this.title,
    required this.updatedOn,
    this.isPhoto = false,
  });
}

class DocumentsVerificationController extends GetxController {
  /// Edit mode shows the camera/upload action on every row.
  final RxBool isEditing = false.obs;

  final RxMap<String, List<VerificationDocument>> sections =
      <String, List<VerificationDocument>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Sample data. TODO: load the uploaded documents from api.
    const updatedOn = "Updated on 9th Jun 2026";
    sections.addAll({
      "Profile Photo": [
        VerificationDocument(
          title: "Profile Photo",
          updatedOn: updatedOn,
          isPhoto: true,
        ),
      ],
      "Government ID Proof": [
        VerificationDocument(title: "Aadhaar ID", updatedOn: updatedOn),
      ],
      "Driving License": [
        VerificationDocument(
          title: "Driving License Front",
          updatedOn: updatedOn,
        ),
        VerificationDocument(
          title: "Driving License Back",
          updatedOn: updatedOn,
        ),
      ],
      "Vehicle RC": [
        VerificationDocument(title: "Vehicle RC Front", updatedOn: updatedOn),
        VerificationDocument(title: "Vehicle RC Back", updatedOn: updatedOn),
      ],
    });
  }

  void onPickDocument(VerificationDocument document) {
    // TODO: capture or pick the new document and upload it.
  }

  void onUpdatePressed(BuildContext context) {
    if (!isEditing.value) {
      isEditing.value = true;
      return;
    }
    // TODO: submit the re-uploaded documents to api.
    isEditing.value = false;
    showSuccessSnackBar("Documents updated successfully", context);
  }
}
