import 'dart:io';

import 'package:chotekisan_delivery_app/Screen/Documents_Verification/documents_verification_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DocumentsVerificationScreen
    extends GetView<DocumentsVerificationController> {
  const DocumentsVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(
              title: "Documents & Verification",
              showBack: true,
            ),

            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final entry in controller.sections.entries) ...[
                        OnestText(
                          text: entry.key,
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0; i < entry.value.length; i++) ...[
                                if (i > 0)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(0xffF0F1F3),
                                    ),
                                  ),
                                _DocumentTile(document: entry.value[i]),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Obx(
            () => CustomButton(
              text: "Update Document",
              height: 48,
              width: width,
              bgcolor: myColors?.green,
              textcolor: Colors.white,
              borderRadius: 12,
              icon: controller.isEditing.value
                  ? null
                  : const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
              onPressed: () => controller.onUpdatePressed(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentTile extends GetView<DocumentsVerificationController> {
  final VerificationDocument document;

  const _DocumentTile({required this.document});

  /// Returns true if the picked file is a PDF.
  bool _isPdf(String path) => path.toLowerCase().endsWith('.pdf');

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // Thumbnail: shows picked image, PDF badge, or placeholder.
          Obx(() {
            final path = document.pickedFilePath.value;
            if (path != null && !_isPdf(path)) {
              // Image thumbnail
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(path),
                  height: 46,
                  width: 46,
                  fit: BoxFit.cover,
                ),
              );
            } else if (path != null && _isPdf(path)) {
              // PDF icon badge
              return Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: const Color(0xffFEE2E2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "PDF",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffDC2626),
                    ),
                  ),
                ),
              );
            } else {
              // Default placeholder
              return Container(
                height: 46,
                width: 46,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xffEDEFF2),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AssetSvgPath.emptyImage),
              );
            }
          }),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnestText(
                  text: document.title,
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize16(context),
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                // Show picked filename when a file is selected, else show date.
                Obx(() {
                  final path = document.pickedFilePath.value;
                  final label = path != null
                      ? path.split(Platform.pathSeparator).last
                      : document.updatedOn;
                  return OnestText(
                    text: label,
                    color: path != null
                        ? myColors?.green
                        : myColors?.primaryText,
                    fontSize: ResponsiveFontSizes.fontSize14(context),
                    fontWeight: FontWeight.w400,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  );
                }),
              ],
            ),
          ),

          // Camera / upload button — visible only in editing mode.
          Obx(
            () => !controller.isEditing.value
                ? const SizedBox()
                : GestureDetector(
                    onTap: () =>
                        controller.onPickDocument(context, document),
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffEEF8F0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffD2F0D7)),
                      ),
                      child: SvgPicture.asset(
                        document.isPhoto
                            ? AssetSvgPath.cameraIconOutlined
                            : AssetSvgPath.uploadIcon,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
