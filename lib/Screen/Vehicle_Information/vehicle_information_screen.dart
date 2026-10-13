import 'package:chotekisan_delivery_app/Screen/Vehicle_Information/vehicle_information_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/custom_textfield.dart';
import 'package:chotekisan_delivery_app/common/registration_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class VehicleInformationScreen extends GetView<VehicleInformationController> {
  const VehicleInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: Color(0xffF8F9FB),

      body: SafeArea(
        top: false,
        child: Column(
          children: [
            RegistrationHeader(step: 2, onBack: controller.onBack),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 22, 16, 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OnestText(
                          text: "Vehicle Information",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize22(context),
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.2,
                        ),
                        SizedBox(height: 2),
                        OnestText(
                          text: "Please provide your vehicle details",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize14(context),
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.35,
                        ),

                        SizedBox(height: 14),

                        OnestText(
                          text: "Vehicle Type",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(height: 12),

                        for (int row = 0; row < 2; row++) ...[
                          if (row != 0) SizedBox(height: 11),
                          Row(
                            children: [
                              for (int i = row * 2; i < row * 2 + 2; i++) ...[
                                if (i.isOdd) SizedBox(width: 11),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.vehicleType.value = i,
                                    child: Obx(
                                      () => Container(
                                        height: 115,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.vehicleType.value == i
                                              ? Color(0xffEEF8F0)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color:
                                                controller.vehicleType.value ==
                                                    i
                                                ? myColors?.green ??
                                                      Colors.green
                                                : Colors.grey.shade200,
                                            width:
                                                controller.vehicleType.value ==
                                                    i
                                                ? 1.2
                                                : 1,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 18),
                                            SvgPicture.asset(
                                              controller
                                                  .vehicleList[i]["icon"]!,
                                              height: 51,
                                            ),
                                            SizedBox(height: 10),
                                            OnestText(
                                              text: controller
                                                  .vehicleList[i]["name"],
                                              color:
                                                  controller
                                                          .vehicleType
                                                          .value ==
                                                      i
                                                  ? myColors?.txt
                                                  : Color(0xff4B5563),
                                              fontSize:
                                                  ResponsiveFontSizes.fontSize17(
                                                    context,
                                                  ),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],

                        SizedBox(height: 24),

                        OnestText(
                          text: "Vehicle Number",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize18(context),
                          fontWeight: FontWeight.w600,
                        ),

                        SizedBox(height: 12),

                        Obx(
                          () => CustomLabelTextfield(
                            label: "Vehicle Registration No",
                            hintText: "Enter vehicle registration number",
                            isRequired: controller.needsVehicleDocs,
                            textEditingController:
                                controller.vehicleNumberController,
                            textCapitalization: TextCapitalization.characters,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9 ]'),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        InfoNoteBox(
                          text:
                              "In next step, RC Document is required for Bike, Scooter and EV based on your selection.",
                        ),
                      ],
                    ),
                  ),

                  if (!keyboardOpen)
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
}
