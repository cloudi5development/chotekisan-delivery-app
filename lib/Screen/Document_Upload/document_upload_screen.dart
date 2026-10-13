import 'dart:io';

import 'package:chotekisan_delivery_app/Screen/Document_Upload/document_upload_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/registration_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DocumentUploadScreen extends GetView<DocumentUploadController> {
  const DocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            RegistrationHeader(step: 3, onBack: controller.onBack),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnestText(
                          text: "Document Upload",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.2,
                        ),
                        SizedBox(height: 2),
                        OnestText(
                          text: "Upload clear photos of the document",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize14(context),
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.35,
                        ),

                        SizedBox(height: 14),

                        documentCard(
                          context,
                          title: "Profile Photo",
                          description: "Clear selfie or passport size photo",
                          file: controller.profilePhoto,
                        ),

                        SizedBox(height: 16),

                        documentCard(
                          context,
                          title: "Government ID Proof",
                          subtitle: "Aadhaar, Voter ID or Passport",
                          description: "Clear front and back side photo",
                          file: controller.idProof,
                        ),

                        SizedBox(height: 16),

                        documentCard(
                          context,
                          title: "Driving License",
                          subtitle: "Required for Bike, Scooter and EV",
                          description: "Clear front and back side photo",
                          file: controller.drivingLicense,
                        ),

                        SizedBox(height: 16),

                        documentCard(
                          context,
                          title: "Vehicle RC",
                          subtitle: "Required for Bike, Scooter and EV",
                          description: "Clear front and back side photo",
                          file: controller.vehicleRc,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 20,
                    child: CustomButton(
                      text: "Next",
                      height: 48,
                      width: width,
                      bgcolor: myColors?.green,
                      textcolor: Colors.white,
                      borderRadius: 16,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => controller.onNext(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget documentCard(
    BuildContext context, {
    required String title,
    String? subtitle,
    required String description,
    required Rxn<File> file,
  }) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnestText(
          text: title,
          color: myColors?.txt,
          fontSize: ResponsiveFontSizes.fontSize18(context),
          fontWeight: FontWeight.w600,
        ),
        if (subtitle != null) ...[
          SizedBox(height: 2),
          OnestText(
            text: subtitle,
            color: myColors?.primaryText,
            fontSize: ResponsiveFontSizes.fontSize14(context),
            fontWeight: FontWeight.w400,
            lineHeight: 1.35,
          ),
        ],

        SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.fromLTRB(10, 9, 12, 9),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Obx(
                () => file.value == null
                    ? SvgPicture.asset(
                        AssetSvgPath.noImage,
                        height: 75,
                        width: 75,
                      )
                    : ClipOval(
                        child: Image.file(
                          file.value!,
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnestText(
                      text: "Photo",
                      color: myColors?.txt,
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 2),
                    OnestText(
                      text: description,
                      color: myColors?.primaryText,
                      fontSize: ResponsiveFontSizes.fontSize14(context),
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.35,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12),

              GestureDetector(
                onTap: () => controller.showImageSourceSheet(context, file),
                child: Container(
                  height: 41,
                  width: 41,
                  decoration: BoxDecoration(
                    color: Color(0xffE6F4EA),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 20,
                    color: myColors?.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
