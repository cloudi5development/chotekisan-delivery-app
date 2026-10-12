import 'package:chotekisan_delivery_app/Screen/Select_Slots/select_slots_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SelectSlotsScreen extends GetView<SelectSlotsController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: SafeArea(
          top: false,
          child: Column(
            children: [
              CustomAppHeader(title: "Select Slots", showBack: true),

              Expanded(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 90),
                      child: Column(
                        children: [
                          InfoNoteBox(
                            text:
                                "Select one or more time slots when you are available to deliver.",
                            backgroundColor: Color(0xffEAFBEF),
                            iconColor: myColors?.green,
                            textColor: Color(0xff4B5563),
                          ),

                          for (final group in controller.slotGroups) ...[
                            SizedBox(
                              height: group == controller.slotGroups.first
                                  ? 12
                                  : 20,
                            ),

                            Container(
                              width: width,
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                10,
                                12,
                                12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        group["icon"] as IconData,
                                        size: 20,
                                        color: group["iconColor"] as Color,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: OnestText(
                                          text: group["title"] as String,
                                          color: myColors?.txt,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize18(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      OnestText(
                                        text: group["range"] as String,
                                        color: myColors?.primaryText,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize15(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8),
                                  Container(
                                    height: 1,
                                    color: Color(0xffE5E7EB),
                                  ),

                                  for (final slot
                                      in group["slots"]
                                          as List<List<String>>) ...[
                                    SizedBox(height: 12),

                                    GestureDetector(
                                      onTap: () =>
                                          controller.toggleSlot(slot[0]),
                                      child: Obx(
                                        () => Container(
                                          height: 51,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                controller.selectedSlots
                                                    .contains(slot[0])
                                                ? Color(0xffEEF8F0)
                                                : Color(0xffF3F4F6),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color:
                                                  controller.selectedSlots
                                                      .contains(slot[0])
                                                  ? myColors?.green ??
                                                        Colors.green
                                                  : Color(0xffE5E7EB),
                                              width:
                                                  controller.selectedSlots
                                                      .contains(slot[0])
                                                  ? 1.2
                                                  : 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  color:
                                                      controller.selectedSlots
                                                          .contains(slot[0])
                                                      ? myColors?.green
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color:
                                                        controller.selectedSlots
                                                            .contains(slot[0])
                                                        ? myColors?.green ??
                                                              Colors.green
                                                        : Color(0xffE5E7EB),
                                                  ),
                                                ),
                                                child:
                                                    controller.selectedSlots
                                                        .contains(slot[0])
                                                    ? Icon(
                                                        Icons.check,
                                                        size: 15,
                                                        color: Colors.white,
                                                      )
                                                    : null,
                                              ),

                                              SizedBox(width: 12),

                                              Flexible(
                                                child: OnestText(
                                                  text: slot[0],
                                                  color:
                                                      controller.selectedSlots
                                                          .contains(slot[0])
                                                      ? myColors?.txt
                                                      : Color(0xff374151),
                                                  fontSize:
                                                      ResponsiveFontSizes.fontSize17(
                                                        context,
                                                      ),
                                                  fontWeight:
                                                      controller.selectedSlots
                                                          .contains(slot[0])
                                                      ? FontWeight.w500
                                                      : FontWeight.w400,
                                                  maxLines: 1,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),

                                              if (slot[1] == "1") ...[
                                                SizedBox(width: 9),
                                                Container(
                                                  height: 24,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                      ),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        controller.selectedSlots
                                                            .contains(slot[0])
                                                        ? Color(0xffC9F2D5)
                                                        : Color(0xffFBEADB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: OnestText(
                                                    text: "₹ High Demand",
                                                    color:
                                                        controller.selectedSlots
                                                            .contains(slot[0])
                                                        ? myColors?.green
                                                        : myColors?.primary,
                                                    fontSize:
                                                        ResponsiveFontSizes.fontSize14(
                                                          context,
                                                        ),
                                                    fontWeight: FontWeight.w500,
                                                    lineHeight: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      child: CustomButton(
                        text: "Confirm Slot & Go Online",
                        height: 48,
                        width: width,
                        bgcolor: myColors?.green,
                        textcolor: Colors.white,
                        borderRadius: 16,
                        onPressed: () => controller.confirmSlots(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
