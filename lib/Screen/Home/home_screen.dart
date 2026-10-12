import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/Screen/Home/home_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/order_widgets.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:chotekisan_delivery_app/common/swipe_to_accept_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final topPadding = MediaQuery.paddingOf(context).top;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FB),

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: width,
                padding: EdgeInsets.fromLTRB(16, topPadding + 14, 16, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff066006),
                      Color(0xff0C8C18),
                      Color(0xff0A7A10),
                    ],
                    stops: [0, 0.65, 1],
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 21,
                              backgroundImage: AssetImage(
                                AssetImagePath.profileImage,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Obx(
                                () => Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    color: controller.isOnline.value
                                        ? Color(0xff18E218)
                                        : Color(0xffE02424),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xff0A6B0D),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 8),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => OnestText(
                                  text: "Hi, ${controller.userName.value}",
                                  color: Colors.white,
                                  fontSize: ResponsiveFontSizes.fontSize19(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.3,
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2),
                              OnestText(
                                text: "Deliver great, Earn more!",
                                color: Colors.white,
                                fontSize: ResponsiveFontSizes.fontSize14(
                                  context,
                                ),
                                fontWeight: FontWeight.w400,
                                lineHeight: 1.35,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.notifications_none_rounded,
                                  size: 22,
                                  color: Color(0xff3C3C3C),
                                ),
                              ),
                              Obx(
                                () => controller.notificationCount.value == 0
                                    ? SizedBox()
                                    : Positioned(
                                        top: 5,
                                        right: 6,
                                        child: Container(
                                          height: 13,
                                          width: 13,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: myColors?.primary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: OnestText(
                                            text:
                                                "${controller.notificationCount.value}",
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            lineHeight: 1,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 12),

                        Container(
                          height: 36,
                          width: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AssetSvgPath.supportIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Online / Offline card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Obx(
                        () => Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                10,
                                12,
                                10,
                              ),
                              color: controller.isOnline.value
                                  ? Color(0xffEEF8F0)
                                  : Color(0xffFDF1F1),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OnestText(
                                          text: controller.isOnline.value
                                              ? "You’re Online"
                                              : "You’re Offline",
                                          color: controller.isOnline.value
                                              ? myColors?.green
                                              : myColors?.error,
                                          fontSize:
                                              ResponsiveFontSizes.fontSize17(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w700,
                                          lineHeight: 1.4,
                                        ),
                                        SizedBox(height: 2),
                                        OnestText(
                                          text: controller.isOnline.value
                                              ? "You are ready to receive orders."
                                              : "Go Online to start receiving orders.",
                                          color: Color(0xff4B5563),
                                          fontSize:
                                              ResponsiveFontSizes.fontSize14(
                                                context,
                                              ),
                                          fontWeight: FontWeight.w400,
                                          lineHeight: 1.35,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 8),

                                  GestureDetector(
                                    onTap: controller.toggleOnline,
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      height: 28,
                                      width: 55,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: controller.isOnline.value
                                            ? Color(0xff07862A)
                                            : Color(0xff9CA3AF),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: AnimatedAlign(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        alignment: controller.isOnline.value
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 56,
                              color: controller.isOnline.value
                                  ? Color(0xffEFEBD9)
                                  : Color(0xffFBE4DA),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 12),
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.access_time,
                                            size: 15,
                                            color: myColors?.primary,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              OnestText(
                                                text: "Working Hours Today",
                                                color: Color(0xff4B5563),
                                                fontSize:
                                                    ResponsiveFontSizes.fontSize13(
                                                      context,
                                                    ),
                                                fontWeight: FontWeight.w400,
                                                lineHeight: 1.4,
                                                maxLines: 1,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 2),
                                              OnestText(
                                                text: controller
                                                    .workingHours
                                                    .value,
                                                color: Color(0xff1F2937),
                                                fontSize:
                                                    ResponsiveFontSizes.fontSize15(
                                                      context,
                                                    ),
                                                fontWeight: FontWeight.w500,
                                                lineHeight: 1.35,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),

                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: controller.onZoneTap,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Icon(
                                              Icons.my_location,
                                              size: 15,
                                              color: myColors?.primary,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                OnestText(
                                                  text:
                                                      controller
                                                          .isFreelancer
                                                          .value
                                                      ? "Zone Selected"
                                                      : "Assigned Zone",
                                                  color: Color(0xff4B5563),
                                                  fontSize:
                                                      ResponsiveFontSizes.fontSize13(
                                                        context,
                                                      ),
                                                  fontWeight: FontWeight.w400,
                                                  lineHeight: 1.4,
                                                ),
                                                SizedBox(height: 2),
                                                OnestText(
                                                  text:
                                                      controller
                                                          .assignedZone
                                                          .value
                                                          .isEmpty
                                                      ? "Not selected"
                                                      : controller
                                                            .assignedZone
                                                            .value,
                                                  color: Color(0xff1F2937),
                                                  fontSize:
                                                      ResponsiveFontSizes.fontSize15(
                                                        context,
                                                      ),
                                                  fontWeight: FontWeight.w500,
                                                  lineHeight: 1.35,
                                                  maxLines: 1,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  20 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  children: [
                    // Freelancer slot banner, tucked behind the summary card
                    Obx(
                      () => controller.isFreelancer.value
                          ? slotBanner(context)
                          : SizedBox(),
                    ),

                    // Today's summary
                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          OnestText(
                            text: "TODAY’S SUMMARY",
                            color: myColors?.txt,
                            fontSize: ResponsiveFontSizes.fontSize13(context),
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 9),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: summaryItem(
                                      context,
                                      "Earnings",
                                      "₹${controller.earnings.value}",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Color(0xffE5E7EB),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: summaryItem(
                                    context,
                                    "Deliveries",
                                    controller.deliveries.value,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 50,
                                  color: Color(0xffE5E7EB),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: summaryItem(
                                    context,
                                    "Incentives",
                                    "₹${controller.incentives.value}",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Obx(
                      () => !controller.isOnline.value
                          ? Column(
                              children: [
                                SizedBox(height: 37),
                                Image.asset(
                                  AssetImagePath.offline,
                                  width: width * 0.87,
                                ),
                                OnestText(
                                  text: "You are Offline!",
                                  color: myColors?.txt,
                                  fontSize: ResponsiveFontSizes.fontSize20(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.3,
                                ),
                                SizedBox(height: 6),
                                OnestText(
                                  textAlign: TextAlign.center,
                                  text: "You won't receive any orders while offline.\nGo online to start delivering and\nearn more.",
                                  color: myColors?.primaryText,
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 1.35,
                                ),
                              ],
                            )
                          : controller.availableOrders.isEmpty &&
                                controller.currentDeliveries.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 22),
                                Image.asset(
                                  AssetImagePath.notYetOrder,
                                  width: width * 0.87,
                                ),
                                OnestText(
                                  text: "No Orders Yet!",
                                  color: myColors?.txt,
                                  fontSize: ResponsiveFontSizes.fontSize20(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 1.3,
                                ),
                                SizedBox(height: 6),
                                OnestText(
                                  textAlign: TextAlign.center,
                                  text: "You're all set and ready to deliver.\nNew orders will appear here.",
                                  color: myColors?.primaryText,
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 1.35,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                if (controller.currentDeliveries.isNotEmpty)
                                  currentDeliveriesSection(context),

                                if (controller.availableOrders.isNotEmpty)
                                  availableOrdersSection(context),
                              ],
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

  Widget slotBanner(BuildContext context) {
    return GestureDetector(
      onTap: controller.onSlotBannerTap,
      child: SizedBox(
        // Only 47 of the banner's height shows, the rest sits behind the
        // rounded top of the summary card
        height: 47,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 61,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 100, 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffF27C0A), Color(0xffF59A2E)],
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: OnestText(
                        text: controller.slotBannerText,
                        color: Colors.white,
                        fontSize: ResponsiveFontSizes.fontSize17(context),
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),

            // Stands on the summary card and overlaps the green header
            Positioned(
              right: 6,
              top: -45,
              child: IgnorePointer(
                child: Image.asset(
                  AssetImagePath.slotBannerPerson,
                  height: 92,
                  width: 86,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    AssetImagePath.inhouseDeliveryPerson,
                    height: 92,
                    width: 86,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryItem(BuildContext context, String label, String value) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      children: [
        OnestText(
          text: label,
          color: Color(0xff4B5563),
          fontSize: ResponsiveFontSizes.fontSize14(context),
          fontWeight: FontWeight.w400,
          lineHeight: 1.35,
        ),
        SizedBox(height: 5),
        OnestText(
          text: value,
          color: myColors?.txt,
          fontSize: ResponsiveFontSizes.fontSize18(context),
          fontWeight: FontWeight.w600,
          lineHeight: 1.3,
        ),
      ],
    );
  }

  Widget currentDeliveriesSection(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final index = controller.currentDeliveryIndex.value.clamp(
      0,
      controller.currentDeliveries.length - 1,
    );
    final order = controller.currentDeliveries[index];
    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OnestText(
                  text: "Current Deliveries",
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize17(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: controller.onViewAllDeliveries,
                child: Row(
                  children: [
                    OnestText(
                      text: "View All",
                      color: myColors?.green,
                      fontSize: ResponsiveFontSizes.fontSize16(context),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 16, color: myColors?.green),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 13),

          GestureDetector(
            onHorizontalDragEnd: (details) =>
                controller.onDeliverySwiped(details.primaryVelocity ?? 0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              decoration: BoxDecoration(
                color: Color(0xffF3F4F6),
                border: Border.all(color: Color(0xffE5E7EB)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderHeader(context, order),

                    SizedBox(height: 11),

                    if (!order.isPickedUp.value) ...[
                      addressBlock(
                        context,
                        icon: Icons.send_rounded,
                        label: "PICKUP",
                        name: order.pickupName,
                        address: order.pickupAddress,
                      ),

                      SizedBox(height: 16),

                      CustomButton(
                        text: "Picked Up",
                        height: 42,
                        width: width,
                        bgcolor: myColors?.green,
                        textcolor: Colors.white,
                        borderRadius: 8,
                        onPressed: () => controller.markPickedUp(order),
                      ),
                    ] else ...[
                      addressBlock(
                        context,
                        icon: Icons.send_rounded,
                        label: "PICKUP",
                        name: order.pickupName,
                        address: order.pickupAddress,
                        showConnector: true,
                      ),
                      addressBlock(
                        context,
                        icon: Icons.location_on,
                        label: "DROP-OFF",
                        name: order.customerName,
                        address: order.dropAddress,
                      ),

                      SizedBox(height: 14),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => controller.callCustomer(order),
                            child: Container(
                              height: 42,
                              width: 96,
                              decoration: BoxDecoration(
                                color: Color(0xffEEF8F0),
                                border: Border.all(color: Color(0xffCFEAD6)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call_outlined,
                                    size: 18,
                                    color: myColors?.green,
                                  ),
                                  SizedBox(width: 8),
                                  OnestText(
                                    text: "Call",
                                    color: myColors?.green,
                                    fontSize: ResponsiveFontSizes.fontSize18(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: CustomButton(
                              text: "Start Delivery",
                              height: 42,
                              width: width,
                              bgcolor: myColors?.green,
                              textcolor: Colors.white,
                              borderRadius: 8,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () => controller.startDelivery(order),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 19,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff6B7280),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: OnestText(
                  text: "${index + 1}/${controller.currentDeliveries.length}",
                  color: Colors.white,
                  fontSize: ResponsiveFontSizes.fontSize13(context),
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.2,
                ),
              ),
              for (
                int i = 0;
                i < (controller.currentDeliveries.length - 1).clamp(0, 2);
                i++
              )
                Container(
                  height: 8,
                  width: 8,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Color(0xff6B7280),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget availableOrdersSection(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OnestText(
                  text: "Available Orders",
                  color: myColors?.txt,
                  fontSize: ResponsiveFontSizes.fontSize17(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 25,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffD9F2DF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: OnestText(
                  text: "${controller.availableOrders.length} Active",
                  color: Color(0xff0B8A2A),
                  fontSize: ResponsiveFontSizes.fontSize14(context),
                  fontWeight: FontWeight.w500,
                  lineHeight: 1.2,
                ),
              ),
            ],
          ),

          SizedBox(height: 11),

          // Only the first two orders are shown, the rest are in View All
          for (final order in controller.availableOrders.take(2)) ...[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              decoration: BoxDecoration(
                color: Color(0xffF3F4F6),
                border: Border.all(color: Color(0xffE5E7EB)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderHeader(context, order),

                  SizedBox(height: 11),

                  addressBlock(
                    context,
                    icon: Icons.send_rounded,
                    label: "PICKUP",
                    name: order.pickupName,
                    address: order.pickupAddress,
                  ),

                  SizedBox(height: 16),

                  SwipeToAcceptButton(
                    key: ValueKey(order.orderId),
                    onAccepted: () => controller.acceptOrder(order),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
          ],

          GestureDetector(
            onTap: controller.onViewAllOrders,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xffFDF0E2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OnestText(
                    text: "View All Orders",
                    color: myColors?.primary,
                    fontSize: ResponsiveFontSizes.fontSize18(context),
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: myColors?.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderHeader(BuildContext context, OrderModel order) {
    return OrderCardHeader(order: order);
  }

  Widget addressBlock(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String name,
    required String address,
    bool showConnector = false,
  }) {
    return OrderAddressBlock(
      icon: icon,
      label: label,
      name: name,
      address: address,
      showConnector: showConnector,
    );
  }
}
