import 'dart:io';

import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VerificationDocument {
  final String title;
  final String updatedOn;

  /// Profile photo rows get a camera action instead of the upload one.
  final bool isPhoto;

  /// Picked file path — null until the user selects a file.
  final Rxn<String> pickedFilePath = Rxn<String>();

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

  final _picker = ImagePicker();

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

  /// Shows the pick-source bottom sheet and stores the chosen file path on
  /// [document].
  void onPickDocument(BuildContext context, VerificationDocument document) {
    Get.bottomSheet(
      _PickSourceSheet(
        isPhoto: document.isPhoto,
        onCamera: () async {
          Get.back();
          await _pickFromCamera(context, document);
        },
        onGallery: () async {
          Get.back();
          await _pickFromGallery(context, document);
        },
        onFile: () async {
          Get.back();
          await _pickFromFiles(context, document);
        },
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  Future<void> _pickFromCamera(
    BuildContext context,
    VerificationDocument document,
  ) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (file != null) {
        document.pickedFilePath.value = file.path;
      }
    } catch (e) {
      _showError(context, "Could not open camera. Please try again.");
    }
  }

  Future<void> _pickFromGallery(
    BuildContext context,
    VerificationDocument document,
  ) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (file == null) return;

      final ext = file.path.split('.').last.toLowerCase();
      if (!_isAllowedImageExt(ext)) {
        _showError(context, "Only PNG or JPEG images are allowed.");
        return;
      }
      document.pickedFilePath.value = file.path;
    } catch (e) {
      _showError(context, "Could not open gallery. Please try again.");
    }
  }

  Future<void> _pickFromFiles(
    BuildContext context,
    VerificationDocument document,
  ) async {
    try {
      // file_picker v13: FilePicker has pure static methods; pickFile returns
      // PlatformFile? directly (null when user cancels).
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
      );
      if (file == null) return;

      final ext = (file.extension ?? '').toLowerCase();
      if (!_isAllowedExt(ext)) {
        _showError(context, 'Only PNG, JPEG, or PDF files are allowed.');
        return;
      }
      document.pickedFilePath.value = file.path;
    } catch (e) {
      _showError(context, 'Could not open file picker. Please try again.');
    }
  }

  bool _isAllowedImageExt(String ext) => ['png', 'jpg', 'jpeg'].contains(ext);
  bool _isAllowedExt(String ext) =>
      ['png', 'jpg', 'jpeg', 'pdf'].contains(ext);

  void _showError(BuildContext context, String message) {
    showErrorSnackBar(message, context);
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

// ── Bottom sheet widget ────────────────────────────────────────────────────────

class _PickSourceSheet extends StatelessWidget {
  final bool isPhoto;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onFile;

  const _PickSourceSheet({
    required this.isPhoto,
    required this.onCamera,
    required this.onGallery,
    required this.onFile,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xffE4E7EC),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Upload Document",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff1A1A2E),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Allowed formats: PNG, JPEG, PDF",
              style: TextStyle(fontSize: 13, color: Color(0xff8C8FA3)),
            ),

            const SizedBox(height: 20),

            // Camera
            _SourceTile(
              icon: Icons.camera_alt_rounded,
              label: "Take a Photo",
              onTap: onCamera,
            ),

            const Divider(height: 1, color: Color(0xffF0F1F3)),

            // Gallery (images only)
            _SourceTile(
              icon: Icons.photo_library_rounded,
              label: "Choose from Gallery",
              subtitle: "PNG, JPEG",
              onTap: onGallery,
            ),

            // File browser (shown for non-photo docs → also allows PDF)
            if (!isPhoto) ...[
              const Divider(height: 1, color: Color(0xffF0F1F3)),
              _SourceTile(
                icon: Icons.folder_open_rounded,
                label: "Browse Files",
                subtitle: "PNG, JPEG, PDF",
                onTap: onFile,
              ),
            ],

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  const _SourceTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      leading: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: const Color(0xffEEF8F0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xff2D7A3A), size: 22),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xff1A1A2E),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff8C8FA3),
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xff8C8FA3),
      ),
      onTap: onTap,
    );
  }
}
