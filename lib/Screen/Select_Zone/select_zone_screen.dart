import 'package:chotekisan_delivery_app/Screen/Select_Zone/select_zone_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectZoneScreen extends GetView<SelectZoneController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: Stack(
          children: [
            // Map area. TODO: replace with the live map and zone boundary.
            Positioned.fill(
              child: Image.asset(
                AssetImagePath.zoneMap,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Color(0xffE5E7EB),
                  alignment: Alignment(0, -0.35),
                  child: Icon(
                    Icons.map_outlined,
                    size: 56,
                    color: Color(0xff9CA3AF),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                CustomAppHeader(title: "Select Zone", showBack: true),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: InfoNoteBox(
                    text: "Select the zone where you want to deliver orders.",
                    subText: "You can change this anytime later.",
                    backgroundColor: Color(0xffF0FDF4),
                    iconColor: myColors?.green,
                    textColor: myColors?.txt,
                  ),
                ),

                Spacer(),

                // Zone list sheet
                Container(
                  width: width,
                  height: keyboardOpen ? height * 0.34 : height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Container(
                        height: 4,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffD1D5DB),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(height: 13),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 47,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: myColors?.borderGray ?? Colors.black12,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.search,
                                size: 22,
                                color: Color(0xff4B5563),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: controller.searchController,
                                  onChanged: (value) =>
                                      controller.search.value = value,
                                  cursorColor: myColors?.green,
                                  style: GoogleFonts.onest(
                                    color: myColors?.txt,
                                    fontSize: ResponsiveFontSizes.fontSize17(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    filled: false,
                                    hintText: "Search by zone name or PIN code",
                                    hintStyle: GoogleFonts.onest(
                                      color: Color(0xff9CA3AF),
                                      fontSize: ResponsiveFontSizes.fontSize17(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 11),

                      Expanded(
                        child: Obx(
                          () => SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    OnestText(
                                      text:
                                          "${controller.filteredZones.length.toString().padLeft(2, '0')} ",
                                      color: myColors?.primary,
                                      fontSize: ResponsiveFontSizes.fontSize17(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    OnestText(
                                      text: "Available Zones",
                                      color: myColors?.txt,
                                      fontSize: ResponsiveFontSizes.fontSize17(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),

                                for (final zone in controller.filteredZones) ...[
                                  SizedBox(height: 11),

                                  GestureDetector(
                                    onTap: () =>
                                        controller.selectedZone.value =
                                            zone["name"] as String,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            controller.selectedZone.value ==
                                                zone["name"]
                                            ? Color(0xffEEF8F0)
                                            : Color(0xffF3F4F6),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              controller.selectedZone.value ==
                                                  zone["name"]
                                              ? myColors?.green ?? Colors.green
                                              : Color(0xffE5E7EB),
                                          width:
                                              controller.selectedZone.value ==
                                                  zone["name"]
                                              ? 1.2
                                              : 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: OnestText(
                                                        text:
                                                            zone["name"]
                                                                as String,
                                                        color: myColors?.txt,
                                                        fontSize:
                                                            ResponsiveFontSizes.fontSize17(
                                                              context,
                                                            ),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        maxLines: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                    if (zone["highDemand"] ==
                                                        true) ...[
                                                      SizedBox(width: 6),
                                                      Container(
                                                        height: 24,
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xffC9F2D5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: OnestText(
                                                          text:
                                                              "High demand zone",
                                                          color:
                                                              myColors?.green,
                                                          fontSize:
                                                              ResponsiveFontSizes.fontSize13(
                                                                context,
                                                              ),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          lineHeight: 1.2,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                                OnestText(
                                                  text:
                                                      zone["distance"]
                                                          as String,
                                                  color: myColors?.primaryText,
                                                  fontSize:
                                                      ResponsiveFontSizes.fontSize15(
                                                        context,
                                                      ),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 4,
                                            ),
                                            child: Icon(
                                              controller.selectedZone.value ==
                                                      zone["name"]
                                                  ? Icons.radio_button_checked
                                                  : Icons.circle_outlined,
                                              size: 22,
                                              color:
                                                  controller
                                                          .selectedZone
                                                          .value ==
                                                      zone["name"]
                                                  ? myColors?.green
                                                  : myColors?.primaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),

                      if (!keyboardOpen)
                        SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                            child: CustomButton(
                              text: "Confirm Zone",
                              height: 48,
                              width: width,
                              bgcolor: myColors?.green,
                              textcolor: Colors.white,
                              borderRadius: 16,
                              onPressed: () => controller.confirmZone(context),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
