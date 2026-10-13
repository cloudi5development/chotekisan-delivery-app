import 'package:chotekisan_delivery_app/Screen/Order_Details/order_details_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/custom_button.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_navigation_flutter/google_navigation_flutter.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    final order = controller.order;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        // Phone back button leaves the riding view first
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) controller.onBackPressed();
        },
        child: Scaffold(
          backgroundColor: Color(0xffF8F9FB),

          body: Stack(
            children: [
              // Delivery map: rider's blue dot and the customer pin
              Positioned.fill(
                child: controller.customerLatLng == null
                    ? Container(
                        color: Color(0xffE5E7EB),
                        alignment: Alignment(0, -0.25),
                        child: Icon(
                          Icons.map_outlined,
                          size: 56,
                          color: Color(0xff9CA3AF),
                        ),
                      )
                    : Obx(
                        () => controller.routeSessionState.value == 1
                            // Map with the route from the rider to the customer
                            ? GoogleMapsNavigationView(
                                key: const ValueKey("routeMap"),
                                initialNavigationUIEnabledPreference:
                                    NavigationUIEnabledPreference.disabled,
                                initialCameraPosition: CameraPosition(
                                  target: controller.customerLatLng!,
                                  zoom: 14,
                                ),
                                initialZoomControlsEnabled: false,
                                initialMapToolbarEnabled: false,
                                initialCompassEnabled: false,
                                // Keeps the route clear of the header and sheet
                                initialPadding: EdgeInsets.only(
                                  top: 170,
                                  bottom: height * 0.4,
                                ),
                                onViewCreated: controller.onRouteMapCreated,
                              )
                            // Plain map until the route is ready
                            : GoogleMapsMapView(
                                key: const ValueKey("plainMap"),
                                initialCameraPosition: CameraPosition(
                                  target: controller.customerLatLng!,
                                  zoom: 14,
                                ),
                                initialZoomControlsEnabled: false,
                                initialMapToolbarEnabled: false,
                                initialCompassEnabled: false,
                                initialPadding: EdgeInsets.only(
                                  top: 170,
                                  bottom: height * 0.4,
                                ),
                                onViewCreated: controller.onMapCreated,
                              ),
                      ),
              ),

              Column(
                children: [
                  // While riding, the header and order card are hidden so
                  // Google's turn banner can use the top of the screen
                  Obx(
                    () => controller.isRiding.value
                        ? SizedBox()
                        : CustomAppHeader(
                            title: "Order Details",
                            showBack: true,
                          ),
                  ),

                  // Order summary
                  Obx(
                    () => Offstage(
                      offstage: controller.isRiding.value,
                      child: Container(
                        width: width,
                        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                        padding: const EdgeInsets.fromLTRB(14, 9, 10, 9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AssetImagePath.orderIcon,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      OnestText(
                                        text: order.orderId,
                                        color: myColors?.txt,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize17(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w700,
                                        lineHeight: 1.4,
                                      ),
                                      if (order.orderType != null) ...[
                                        SizedBox(width: 6),
                                        Container(
                                          height: 22,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Color(0xffE8EEFB),
                                            borderRadius: BorderRadius.circular(
                                              11,
                                            ),
                                          ),
                                          child: OnestText(
                                            text: order.orderType,
                                            color: Color(0xff2563EB),
                                            fontSize:
                                                ResponsiveFontSizes.fontSize13(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w400,
                                            lineHeight: 1.2,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  // Live distance and time left, counts down as the
                                  // rider moves
                                  Obx(
                                    () => OnestText(
                                      text: controller.timeText == null
                                          ? "Delivery  |  ${controller.distanceText}"
                                          : "Delivery  |  ${controller.distanceText}  |  ${controller.timeText}",
                                      color: myColors?.primary,
                                      fontSize: ResponsiveFontSizes.fontSize13(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                OnestText(
                                  text: "₹${order.amount}",
                                  color: myColors?.txt,
                                  fontSize: ResponsiveFontSizes.fontSize17(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  lineHeight: 1.4,
                                ),
                                OnestText(
                                  text: order.isCod
                                      ? "COD ₹${order.collectAmount}"
                                      : order.paymentType,
                                  color: Color(0xff4B5563),
                                  fontSize: ResponsiveFontSizes.fontSize13(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 1.4,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Shown when GPS is off or location permission is missing
                  Obx(
                    () =>
                        controller.isRiding.value ||
                            (controller.locationState.value == 0 &&
                                controller.routeError.value == null)
                        ? SizedBox()
                        : Container(
                            width: width,
                            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_off_outlined,
                                  size: 18,
                                  color: myColors?.primary,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: OnestText(
                                    text: controller.locationState.value != 0
                                        ? controller.locationMessage
                                        : controller.routeError.value,
                                    color: Color(0xff374151),
                                    fontSize: ResponsiveFontSizes.fontSize14(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    lineHeight: 1.35,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: controller.locationState.value != 0
                                      ? controller.onLocationAction
                                      : controller.onRetryRoute,
                                  child: OnestText(
                                    text: controller.locationState.value != 0
                                        ? controller.locationActionText
                                        : "Retry",
                                    color: myColors?.green,
                                    fontSize: ResponsiveFontSizes.fontSize14(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),

                  // Shown while the route is still being worked out
                  Obx(
                    () =>
                        controller.isRouteLoading && !controller.isRiding.value
                        ? Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: myColors?.green,
                                  ),
                                ),
                                SizedBox(width: 8),
                                OnestText(
                                  text: "Finding route...",
                                  color: Color(0xff374151),
                                  fontSize: ResponsiveFontSizes.fontSize14(
                                    context,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),

                  Spacer(),

                  // Navigate and map controls, hidden while riding
                  Obx(
                    () => Offstage(
                      offstage: controller.isRiding.value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                        child: Row(
                          children: [
                            // Before arriving: start riding. After arriving
                            // there is nothing left to navigate.
                            if (!controller.hasArrived.value)
                              GestureDetector(
                                onTap: () => controller.onNavigate(context),
                                child: Container(
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.12,
                                        ),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.near_me,
                                        size: 18,
                                        color: myColors?.greenColor,
                                      ),
                                      SizedBox(width: 6),
                                      OnestText(
                                        text: "Navigate",
                                        color: myColors?.greenColor,
                                        fontSize:
                                            ResponsiveFontSizes.fontSize17(
                                              context,
                                            ),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            SizedBox(width: 6),

                            GestureDetector(
                              onTap: controller.onRecenter,
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.my_location,
                                  size: 20,
                                  color: myColors?.greenColor,
                                ),
                              ),
                            ),

                            Spacer(),

                            // Voice guidance on / off
                            if (!controller.hasArrived.value)
                              GestureDetector(
                                onTap: controller.toggleVoice,
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.12,
                                        ),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Obx(
                                    () => Icon(
                                      controller.voiceOn.value
                                          ? Icons.volume_up_rounded
                                          : Icons.volume_off_rounded,
                                      size: 20,
                                      color: controller.voiceOn.value
                                          ? myColors?.greenColor
                                          : myColors?.primaryText,
                                    ),
                                  ),
                                ),
                              ),

                            SizedBox(width: 6),

                            // Full screen map on / off
                            GestureDetector(
                              onTap: () => controller.toggleFullScreen(height),
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Obx(
                                  () => Icon(
                                    controller.isFullScreen.value
                                        ? Icons.fullscreen_exit_rounded
                                        : Icons.fullscreen_rounded,
                                    size: 22,
                                    color: myColors?.greenColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Customer details sheet, grows when the items are shown.
                  // Hidden while the map is in full screen, and replaced by the
                  // large distance bar while riding.
                  Obx(
                    () => controller.isRiding.value
                        ? rideBar(context)
                        : controller.isFullScreen.value
                        ? SizedBox(
                            height: MediaQuery.paddingOf(context).bottom + 6,
                          )
                        : Container(
                            width: width,
                            constraints: BoxConstraints(
                              maxHeight: height * 0.68,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            child: SafeArea(
                              top: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.fromLTRB(
                                        16,
                                        15,
                                        16,
                                        16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Arrived: shown once the rider taps
                                          // Arrived or reaches the customer
                                          Obx(
                                            () => controller.hasArrived.value
                                                ? Container(
                                                    width: width,
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 14,
                                                        ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffEEF8F0),
                                                      border: Border.all(
                                                        color: Color(
                                                          0xffCFEAD6,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 41,
                                                          width: 41,
                                                          decoration:
                                                              BoxDecoration(
                                                                color: myColors
                                                                    ?.green,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Icon(
                                                            Icons.check_rounded,
                                                            size: 26,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              OnestText(
                                                                text: "You have arrived!",
                                                                color: myColors
                                                                    ?.greenColor,
                                                                fontSize:
                                                                    ResponsiveFontSizes.fontSize18(
                                                                      context,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                lineHeight:
                                                                    1.35,
                                                              ),
                                                              OnestText(
                                                                text: "Hand over the order, then close the delivery.",
                                                                color: Color(
                                                                  0xff4B5563,
                                                                ),
                                                                fontSize:
                                                                    ResponsiveFontSizes.fontSize14(
                                                                      context,
                                                                    ),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                lineHeight:
                                                                    1.35,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ),

                                          OnestText(
                                            text: "Customer Details",
                                            color: myColors?.txt,
                                            fontSize:
                                                ResponsiveFontSizes.fontSize18(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w600,
                                          ),

                                          SizedBox(height: 10),

                                          Row(
                                            children: [
                                              Container(
                                                height: 42,
                                                width: 42,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffEDEDED),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: OnestText(
                                                  text: controller
                                                      .customerInitials,
                                                  color: Color(0xff4B5563),
                                                  fontSize:
                                                      ResponsiveFontSizes.fontSize16(
                                                        context,
                                                      ),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                              SizedBox(width: 8),

                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    OnestText(
                                                      text: order.customerName,
                                                      color: Color(0xff374151),
                                                      fontSize:
                                                          ResponsiveFontSizes.fontSize17(
                                                            context,
                                                          ),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      lineHeight: 1.4,
                                                    ),
                                                    OnestText(
                                                      text:
                                                          "+91 ${order.customerMobile}",
                                                      color: Color(0xff4B5563),
                                                      fontSize:
                                                          ResponsiveFontSizes.fontSize16(
                                                            context,
                                                          ),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      lineHeight: 1.4,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              GestureDetector(
                                                onTap: () =>
                                                    controller.onCall(context),
                                                child: Container(
                                                  height: 38,
                                                  width: 85,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffEEF8F0),
                                                    border: Border.all(
                                                      color: Color(0xffCFEAD6),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.call_outlined,
                                                        size: 18,
                                                        color: myColors?.green,
                                                      ),
                                                      SizedBox(width: 6),
                                                      OnestText(
                                                        text: "Call",
                                                        color: myColors?.green,
                                                        fontSize:
                                                            ResponsiveFontSizes.fontSize17(
                                                              context,
                                                            ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 10),

                                          OnestText(
                                            text: order.dropAddress,
                                            color: myColors?.primaryText,
                                            fontSize:
                                                ResponsiveFontSizes.fontSize14(
                                                  context,
                                                ),
                                            fontWeight: FontWeight.w400,
                                            lineHeight: 1.35,
                                          ),

                                          SizedBox(height: 16),

                                          // Order items
                                          Obx(
                                            () => Container(
                                              width: width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Color(0xffF3F4F6),
                                                border: Border.all(
                                                  color: Color(0xffE5E7EB),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap:
                                                        controller.toggleItems,
                                                    child: SizedBox(
                                                      height: 38,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: OnestText(
                                                              text:
                                                                  "Order Items (${order.items.length})",
                                                              color:
                                                                  myColors?.txt,
                                                              fontSize:
                                                                  ResponsiveFontSizes.fontSize16(
                                                                    context,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          OnestText(
                                                            text:
                                                                controller
                                                                    .showItems
                                                                    .value
                                                                ? "Hide"
                                                                : "Show",
                                                            color: myColors
                                                                ?.primary,
                                                            fontSize:
                                                                ResponsiveFontSizes.fontSize14(
                                                                  context,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          SizedBox(width: 6),
                                                          Icon(
                                                            controller
                                                                    .showItems
                                                                    .value
                                                                ? Icons
                                                                      .keyboard_arrow_up
                                                                : Icons
                                                                      .keyboard_arrow_down,
                                                            size: 20,
                                                            color: myColors
                                                                ?.primary,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  if (controller
                                                      .showItems
                                                      .value) ...[
                                                    SizedBox(height: 4),

                                                    for (final item
                                                        in order.items) ...[
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 34,
                                                            width: 34,
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  3,
                                                                ),
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        6,
                                                                      ),
                                                                ),
                                                            child: Image.asset(
                                                              item["image"] ??
                                                                  "",
                                                              fit: BoxFit
                                                                  .contain,
                                                              errorBuilder:
                                                                  (
                                                                    context,
                                                                    error,
                                                                    stackTrace,
                                                                  ) => Icon(
                                                                    Icons
                                                                        .shopping_basket_outlined,
                                                                    size: 18,
                                                                    color: Color(
                                                                      0xff9CA3AF,
                                                                    ),
                                                                  ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: OnestText(
                                                              text:
                                                                  item["name"] ??
                                                                  "",
                                                              color: Color(
                                                                0xff374151,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveFontSizes.fontSize16(
                                                                    context,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              maxLines: 1,
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          SizedBox(width: 8),
                                                          OnestText(
                                                            text:
                                                                item["quantity"] ??
                                                                "",
                                                            color: Color(
                                                              0xff4B5563,
                                                            ),
                                                            fontSize:
                                                                ResponsiveFontSizes.fontSize16(
                                                                  context,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),

                                                      SizedBox(height: 14),
                                                    ],

                                                    Container(
                                                      height: 1,
                                                      color: Color(0xffD1D5DB),
                                                    ),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 13,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: OnestText(
                                                              text:
                                                                  "Order Total",
                                                              color: Color(
                                                                0xff374151,
                                                              ),
                                                              fontSize:
                                                                  ResponsiveFontSizes.fontSize16(
                                                                    context,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          OnestText(
                                                            text:
                                                                "₹${order.orderTotal}",
                                                            color:
                                                                myColors?.txt,
                                                            fontSize:
                                                                ResponsiveFontSizes.fontSize16(
                                                                  context,
                                                                ),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      20,
                                    ),
                                    child: CustomButton(
                                      text: "Close Delivery",
                                      height: 48,
                                      width: width,
                                      bgcolor: myColors?.green,
                                      textcolor: Colors.white,
                                      borderRadius: 16,
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: controller.onCloseDelivery,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom bar while riding: distance and time as the headline, with large
  // voice and exit buttons
  Widget rideBar(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Recenter: back to following the rider after the map is dragged
        Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 10),
          child: GestureDetector(
            onTap: controller.onRecenter,
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.my_location,
                size: 26,
                color: myColors?.greenColor,
              ),
            ),
          ),
        ),

        Container(
          width: width,
          padding: EdgeInsets.fromLTRB(
            16,
            14,
            16,
            14 + MediaQuery.paddingOf(context).bottom,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnestText(
                          text: controller.timeText == null
                              ? controller.distanceText
                              : "${controller.distanceText}  ·  ${controller.timeText}",
                          color: myColors?.txt,
                          fontSize: ResponsiveFontSizes.fontSize30(context),
                          fontWeight: FontWeight.w700,
                          lineHeight: 1.25,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        OnestText(
                          text: "To ${controller.order.customerName}",
                          color: myColors?.primaryText,
                          fontSize: ResponsiveFontSizes.fontSize15(context),
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 10),

                  // Voice guidance on / off
                  GestureDetector(
                    onTap: controller.toggleVoice,
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: controller.voiceOn.value
                            ? Color(0xffEEF8F0)
                            : Color(0xffF3F4F6),
                        border: Border.all(
                          color: controller.voiceOn.value
                              ? Color(0xffCFEAD6)
                              : Color(0xffE5E7EB),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.voiceOn.value
                            ? Icons.volume_up_rounded
                            : Icons.volume_off_rounded,
                        size: 26,
                        color: controller.voiceOn.value
                            ? myColors?.greenColor
                            : myColors?.primaryText,
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  GestureDetector(
                    onTap: controller.exitRide,
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffFDF1F1),
                        border: Border.all(color: Color(0xffF5C6C6)),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: OnestText(
                        text: "Exit",
                        color: myColors?.error,
                        fontSize: ResponsiveFontSizes.fontSize18(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
