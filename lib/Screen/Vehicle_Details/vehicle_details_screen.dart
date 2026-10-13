import 'package:chotekisan_delivery_app/Screen/Vehicle_Details/vehicle_details_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VehicleDetailsScreen extends GetView<VehicleDetailsController> {
  const VehicleDetailsScreen({super.key});

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
            const CustomAppHeader(title: "Vehicle Details", showBack: true),

            Expanded(
              child: Obx(() {
                final details = controller.details.value;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gradient summary card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff0A7A10),
                              Color(0xff5FA50C),
                              Color(0xffC3D500),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OnestText(
                                    text: "Vehicle Type",
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: ResponsiveFontSizes.fontSize14(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  OnestText(
                                    text: details.vehicleType.isEmpty
                                        ? "--"
                                        : details.vehicleType,
                                    color: Colors.white,
                                    fontSize: ResponsiveFontSizes.fontSize17(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(height: 8),
                                  OnestText(
                                    text: "Vehicle Number",
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: ResponsiveFontSizes.fontSize14(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  OnestText(
                                    text: details.vehicleNumber.isEmpty
                                        ? "--"
                                        : details.vehicleNumber,
                                    color: Colors.white,
                                    fontSize: ResponsiveFontSizes.fontSize17(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              AssetSvgPath.scooter,
                              height: 78,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      OnestText(
                        text: "Vehicle Overview",
                        color: myColors?.txt,
                        fontSize: ResponsiveFontSizes.fontSize18(context),
                        fontWeight: FontWeight.w700,
                      ),

                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            _OverviewRow(
                              label: "Brand",
                              value: details.brand,
                            ),
                            _OverviewRow(
                              label: "Model",
                              value: details.model,
                            ),
                            _OverviewRow(
                              label: "Color",
                              value: details.color,
                            ),
                            _OverviewRow(
                              label: "Year of Manufacture",
                              value: details.yearOfManufacture,
                            ),
                            _OverviewRow(
                              label: "RC Number",
                              value: details.rcNumber,
                            ),
                            _OverviewRow(
                              label: "Registration Date",
                              value: details.registrationDate,
                            ),
                            _OverviewRow(
                              label: "Insurance Validity",
                              value: details.insuranceValidity,
                            ),
                            _OverviewRow(
                              label: "PUC Validity",
                              value: details.pucValidity,
                              isLast: true,
                            ),
                          ],
                        ),
                      ),

                      if (controller.isIncomplete) ...[
                        const SizedBox(height: 16),
                        const InfoNoteBox(
                          text:
                              "Update your vehicle details to get support from our chotekisan team in case of emergency.",
                          backgroundColor: Color(0xffE8EAED),
                          iconColor: Color(0xff4B5563),
                          textColor: Color(0xff4B5563),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: CustomButton(
            text: "Update Vehicle Details",
            height: 48,
            width: width,
            bgcolor: myColors?.green,
            textcolor: Colors.white,
            borderRadius: 24,
            icon: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ),
            onPressed: () => Get.toNamed(AppRoutes.updateVehicleDetails),
          ),
        ),
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _OverviewRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xffF0F1F3)),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OnestText(
              text: label,
              color: myColors?.primaryText,
              fontSize: ResponsiveFontSizes.fontSize16(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          OnestText(
            text: value.isEmpty ? "--" : value,
            color: myColors?.txt,
            fontSize: ResponsiveFontSizes.fontSize16(context),
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
