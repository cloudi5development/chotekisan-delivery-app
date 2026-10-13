import 'dart:async';
import 'package:chotekisan_delivery_app/Model/order_model.dart';
import 'package:chotekisan_delivery_app/Screen/Home/home_controller.dart';
import 'package:chotekisan_delivery_app/common/cash_collect_sheet.dart';
import 'package:chotekisan_delivery_app/common/common_widgets.dart';
import 'package:chotekisan_delivery_app/common/verify_close_sheet.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:chotekisan_delivery_app/common/phone_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_navigation_flutter/google_navigation_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class OrderDetailsController extends GetxController
    with WidgetsBindingObserver {
  late final OrderModel order;

  RxBool showItems = false.obs;

  // Map controls
  RxBool isFullScreen = false.obs;
  // Voice guidance starts off on every delivery, the rider turns it on
  RxBool voiceOn = false.obs;

  // Riding view: Google's turn banner on top, a large distance bar below,
  // and everything else hidden
  RxBool isRiding = false.obs;
  double _screenHeight = 800;
  double _topInset = 0;

  // True while the route is still being worked out
  bool get isRouteLoading =>
      customerLatLng != null &&
      locationGranted.value &&
      !routeActive.value &&
      !hasArrived.value &&
      routeError.value == null;

  // Confirm Cash Collected sheet (COD only)
  // null = nothing chosen, 0 = In-hand, 1 = Scan & Collect
  RxnInt cashMode = RxnInt();
  RxBool paymentReceived = false.obs;
  Timer? _paymentTimer;

  // Verify to Close Delivery sheet
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();
  RxString otp = "".obs;
  RxBool hasFocus = false.obs;
  RxInt secondsLeft = 30.obs;
  Timer? _otpTimer;

  // Delivery map
  GoogleMapViewController? mapController;
  GoogleNavigationViewController? routeController;
  bool _checkingLocation = false;

  // 0 = ready, 1 = GPS turned off, 2 = permission denied,
  // 3 = permission denied permanently (must be allowed from app settings)
  RxInt locationState = 0.obs;
  RxBool locationGranted = false.obs;

  // Route from the rider to the customer, drawn inside the app
  // 0 = not started, 1 = ready to draw, 2 = could not start (plain map)
  RxInt routeSessionState = 0.obs;
  bool _startingSession = false;
  bool _sessionStarted = false;
  bool _routeRequested = false;
  RxBool routeActive = false.obs;
  RxBool hasArrived = false.obs;
  RxnString routeError = RxnString();
  StreamSubscription<RemainingTimeOrDistanceChangedEvent>? _remainingSub;
  StreamSubscription<OnArrivalEvent>? _arrivalSub;
  StreamSubscription<Position>? _positionSub;

  // Live distance and time left. Road distance while the route is active,
  // otherwise the straight-line distance from the rider's position.
  RxnDouble remainingMeters = RxnDouble();
  RxnDouble remainingSeconds = RxnDouble();

  String get customerInitials {
    final parts = order.customerName.trim().split(RegExp(r'\s+'));
    return parts.take(2).map((part) => part.isEmpty ? "" : part[0]).join();
  }

  // TODO: replace with the payment QR / UPI link from api.
  String get paymentQrData =>
      "upi://pay?pn=ChoteKisan&am=${order.collectAmount}&tn=${order.orderId}";

  String get timerText => "00:${secondsLeft.value.toString().padLeft(2, '0')}";

  LatLng? get customerLatLng =>
      order.dropLatitude == null || order.dropLongitude == null
      ? null
      : LatLng(
          latitude: order.dropLatitude!,
          longitude: order.dropLongitude!,
        );

  // e.g. "1.8 Km" or "350 m", counting down as the rider moves
  String get distanceText {
    if (hasArrived.value) return "Arrived";
    final meters = remainingMeters.value;
    if (meters == null) return order.distance;
    if (meters < 1000) return "${meters.round()} m";
    return "${(meters / 1000).toStringAsFixed(1)} Km";
  }

  // e.g. "6 min", only known while the road route is active
  String? get timeText {
    final seconds = remainingSeconds.value;
    if (seconds == null || hasArrived.value) return null;
    final minutes = (seconds / 60).ceil();
    if (minutes < 60) return "$minutes min";
    return "${minutes ~/ 60} h ${minutes % 60} min";
  }

  String get locationMessage {
    switch (locationState.value) {
      case 1:
        return "Location is turned off on this phone.";
      case 2:
        return "Allow location to see your route on the map.";
      default:
        return "Location is blocked for this app.";
    }
  }

  String get locationActionText {
    switch (locationState.value) {
      case 1:
        return "Turn on";
      case 2:
        return "Allow";
      default:
        return "Open settings";
    }
  }

  @override
  void onInit() {
    super.onInit();
    order = Get.arguments as OrderModel;
    otpFocusNode.addListener(() {
      hasFocus.value = otpFocusNode.hasFocus;
    });
    WidgetsBinding.instance.addObserver(this);
    checkLocation();
  }

  // Coming back from the phone's settings: look again, but do not pop the
  // permission prompt a second time on its own
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && locationState.value != 0) {
      checkLocation(askPermission: false);
    }
  }

  Future<void> checkLocation({bool askPermission = true}) async {
    if (_checkingLocation) return;
    _checkingLocation = true;
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        locationGranted.value = false;
        locationState.value = 1;
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied && askPermission) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        locationGranted.value = false;
        locationState.value = 2;
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        locationGranted.value = false;
        locationState.value = 3;
        return;
      }
      locationState.value = 0;
      locationGranted.value = true;
      mapController?.setMyLocationEnabled(true);
      _listenToPosition();
      _startRouteSession();
    } catch (e) {
      debugPrint("Location check failed: $e");
    } finally {
      _checkingLocation = false;
    }
  }

  void onLocationAction() {
    switch (locationState.value) {
      case 1:
        Geolocator.openLocationSettings();
      case 2:
        checkLocation();
      default:
        Geolocator.openAppSettings();
    }
  }

  // Keeps the straight-line distance up to date until (or unless) the road
  // route takes over
  void _listenToPosition() {
    final customer = customerLatLng;
    if (customer == null || _positionSub != null) return;
    _positionSub =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        ).listen((position) {
          if (routeActive.value) return;
          remainingMeters.value = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            customer.latitude,
            customer.longitude,
          );
        }, onError: (Object e) => debugPrint("Position stream failed: $e"));
  }

  // Google's navigation session works out the road route and follows it
  Future<void> _startRouteSession() async {
    if (customerLatLng == null || _startingSession || _sessionStarted) return;
    _startingSession = true;
    try {
      // Google requires its navigation terms to be accepted once per phone
      if (!await GoogleMapsNavigator.areTermsAccepted()) {
        final accepted = await GoogleMapsNavigator.showTermsAndConditionsDialog(
          "Navigation",
          "ChoteKisan",
        );
        if (!accepted) {
          _routeFailed("Accept the navigation terms to see your route.");
          return;
        }
      }
      await GoogleMapsNavigator.initializeNavigationSession(
        taskRemovedBehavior: TaskRemovedBehavior.quitService,
      );
      _sessionStarted = true;
      if (isClosed) {
        _cleanupRoute();
        return;
      }
      _remainingSub =
          GoogleMapsNavigator.setOnRemainingTimeOrDistanceChangedListener((
            event,
          ) {
            if (!routeActive.value) return;
            remainingMeters.value = event.remainingDistance;
            remainingSeconds.value = event.remainingTime;
          }, remainingDistanceThresholdMeters: 10);
      // Google also marks arrival by itself when the rider reaches the pin
      _arrivalSub = GoogleMapsNavigator.setOnArrivalListener((event) {
        markArrived();
      });
      routeSessionState.value = 1;
    } catch (e) {
      debugPrint("Route session failed: $e");
      _routeFailed("The route could not be loaded on this phone.");
    } finally {
      _startingSession = false;
    }
  }

  // Plain map (no route), used when the route session could not start
  void onMapCreated(GoogleMapViewController controller) {
    mapController = controller;
    if (locationGranted.value) {
      controller.setMyLocationEnabled(true);
    }
    _addCustomerPin();
  }

  // Map that can draw the route
  void onRouteMapCreated(GoogleNavigationViewController controller) {
    mapController = controller;
    routeController = controller;
    controller.setMyLocationEnabled(true);
    _drawRoute();
  }

  void _addCustomerPin() {
    if (customerLatLng == null) return;
    mapController?.addMarkers([
      MarkerOptions(
        position: customerLatLng!,
        infoWindow: InfoWindow(title: order.customerName),
      ),
    ]);
  }

  Future<void> _drawRoute() async {
    if (_routeRequested) return;
    _routeRequested = true;
    try {
      NavigationRouteStatus status = await _setDestination(
        NavigationTravelMode.twoWheeler,
      );
      // Two-wheeler routes are not offered everywhere
      if (status == NavigationRouteStatus.travelModeUnsupported) {
        status = await _setDestination(NavigationTravelMode.driving);
      }
      // The phone may still be finding its GPS position, so try again
      for (
        int attempt = 0;
        attempt < 5 &&
            (status == NavigationRouteStatus.locationUnavailable ||
                status == NavigationRouteStatus.locationUnknown);
        attempt++
      ) {
        await Future.delayed(const Duration(seconds: 2));
        if (isClosed) return;
        status = await _setDestination(NavigationTravelMode.twoWheeler);
      }
      if (isClosed) return;
      if (status != NavigationRouteStatus.statusOk) {
        debugPrint("Route request failed with status: $status");
        _routeRequested = false;
        _addCustomerPin();
        routeError.value = _statusMessage(status);
        return;
      }
      // Set the voice choice first so nothing is spoken before it applies
      await _applyVoice();
      await GoogleMapsNavigator.startGuidance();
      await _applyVoice();
      // Show only the route line and the rider, our own cards sit on top
      await routeController?.setNavigationUIEnabled(true);
      await routeController?.setNavigationHeaderEnabled(false);
      await routeController?.setNavigationFooterEnabled(false);
      await routeController?.setSpeedometerEnabled(false);
      await routeController?.setSpeedLimitIconEnabled(false);
      await routeController?.setRecenterButtonEnabled(false);
      await routeController?.setReportIncidentButtonEnabled(false);
      routeError.value = null;
      routeActive.value = true;
      // Stop the phone dimming or locking while a route is being followed
      WakelockPlus.enable();
      final current = await GoogleMapsNavigator.getCurrentTimeAndDistance();
      remainingMeters.value = current.distance;
      remainingSeconds.value = current.time;
      // Start with the whole route in view
      await routeController?.showRouteOverview();
    } catch (e) {
      debugPrint("Draw route failed: $e");
      _routeRequested = false;
      routeError.value = "The route could not be loaded for this order.";
    }
  }

  Future<NavigationRouteStatus> _setDestination(NavigationTravelMode mode) {
    return GoogleMapsNavigator.setDestinations(
      Destinations(
        waypoints: [
          NavigationWaypoint.withLatLngTarget(
            title: order.customerName,
            target: customerLatLng!,
          ),
        ],
        displayOptions: NavigationDisplayOptions(showDestinationMarkers: true),
        routingOptions: RoutingOptions(travelMode: mode),
      ),
    );
  }

  String _statusMessage(NavigationRouteStatus status) {
    switch (status) {
      case NavigationRouteStatus.apiKeyNotAuthorized:
        return "Routes are not enabled for this app's Google key yet.";
      case NavigationRouteStatus.networkError:
        // Google also reports this when the key is not allowed to use the
        // Navigation SDK, so it does not always mean the phone is offline
        return "The route could not be loaded from Google. Please try again.";
      case NavigationRouteStatus.routeNotFound:
        return "No route was found to the customer's location.";
      case NavigationRouteStatus.locationUnavailable:
      case NavigationRouteStatus.locationUnknown:
        return "Your location could not be found. Move to an open area.";
      case NavigationRouteStatus.quotaExceeded:
      case NavigationRouteStatus.quotaCheckFailed:
        return "Routes are temporarily unavailable. Please try again later.";
      default:
        return "The route could not be loaded for this order.";
    }
  }

  void _routeFailed(String message) {
    routeError.value = message;
    routeSessionState.value = 2;
  }

  void onRetryRoute() {
    if (routeSessionState.value == 1) {
      routeError.value = null;
      _drawRoute();
    } else {
      routeError.value = null;
      routeSessionState.value = 0;
      _startRouteSession();
    }
  }

  void toggleItems() {
    showItems.value = !showItems.value;
  }

  // Hides the customer details sheet so the map fills the screen
  void toggleFullScreen(double screenHeight) {
    _screenHeight = screenHeight;
    isFullScreen.value = !isFullScreen.value;
    _applyMapPadding();
  }

  // Keeps the route clear of whatever is covering the map right now
  void _applyMapPadding() {
    final EdgeInsets padding;
    if (isRiding.value) {
      padding = EdgeInsets.only(top: _topInset, bottom: 110);
    } else if (isFullScreen.value) {
      padding = const EdgeInsets.only(top: 170, bottom: 76);
    } else {
      padding = EdgeInsets.only(top: 170, bottom: _screenHeight * 0.4);
    }
    mapController?.setPadding(padding);
  }

  // The rider tapped Arrived, or Google detected arrival. Ends guidance and
  // brings back the customer sheet with the arrived message and Close Delivery.
  Future<void> markArrived() async {
    if (hasArrived.value) return;
    hasArrived.value = true;
    // TODO: call the arrived api here if the backend tracks it.
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.alert);
    WakelockPlus.disable();
    try {
      if (_sessionStarted) {
        await GoogleMapsNavigator.stopGuidance();
      }
      await routeController?.setNavigationUIEnabled(false);
    } catch (e) {
      debugPrint("Stop guidance failed: $e");
    }
    // Back to the normal layout, with the customer pin still on the map
    isRiding.value = false;
    isFullScreen.value = false;
    _applyMapPadding();
    _addCustomerPin();
  }

  // Leaves the riding view and brings back the customer details
  Future<void> exitRide() async {
    if (!isRiding.value && !isFullScreen.value) return;
    isRiding.value = false;
    isFullScreen.value = false;
    try {
      await routeController?.setNavigationHeaderEnabled(false);
      _applyMapPadding();
      if (routeActive.value && !hasArrived.value) {
        await routeController?.showRouteOverview();
      }
    } catch (e) {
      debugPrint("Exit ride failed: $e");
    }
  }

  // Phone back button: leave the riding view first, then the screen
  void onBackPressed() {
    if (isRiding.value) {
      exitRide();
    } else {
      Get.back();
    }
  }

  void toggleVoice() {
    voiceOn.value = !voiceOn.value;
    _applyVoice();
  }

  // Turn-by-turn voice guidance. Only takes effect once the route session
  // has started, so it is applied again when the route is drawn.
  Future<void> _applyVoice() async {
    if (!_sessionStarted) return;
    try {
      await GoogleMapsNavigator.setAudioGuidance(
        NavigationAudioGuidanceSettings(
          guidanceType: voiceOn.value
              ? NavigationAudioGuidanceType.alertsAndGuidance
              : NavigationAudioGuidanceType.silent,
        ),
      );
    } catch (e) {
      debugPrint("Set voice guidance failed: $e");
    }
  }

  // One tap to start riding: full screen, Google's turn banner, and the map
  // tilted and following the rider along the route, all inside the app
  Future<void> onNavigate(BuildContext context) async {
    _screenHeight = MediaQuery.sizeOf(context).height;
    _topInset = MediaQuery.paddingOf(context).top;
    if (customerLatLng == null) {
      showErrorSnackBar(
        "Customer location is not available for this order",
        context,
      );
      return;
    }
    if (locationState.value != 0 || !locationGranted.value) {
      showErrorSnackBar(locationMessage, context);
      onLocationAction();
      return;
    }
    if (!routeActive.value) {
      showErrorSnackBar(
        routeError.value ?? "The route is still loading",
        context,
      );
      if (routeError.value != null) onRetryRoute();
      return;
    }
    isRiding.value = true;
    try {
      await routeController?.setNavigationHeaderEnabled(true);
      _applyMapPadding();
      await routeController?.followMyLocation(CameraPerspective.tilted);
    } catch (e) {
      debugPrint("Start ride failed: $e");
    }
  }

  // Brings the map back to the rider after they have dragged it away.
  // While riding it returns to the tilted view that follows them.
  Future<void> onRecenter() async {
    if (locationState.value != 0 || !locationGranted.value) {
      onLocationAction();
      return;
    }
    try {
      if (isRiding.value) {
        await routeController?.followMyLocation(CameraPerspective.tilted);
        return;
      }
      if (routeActive.value) {
        await routeController?.followMyLocation(
          CameraPerspective.topDownNorthUp,
          zoomLevel: 16,
        );
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      await mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(latitude: position.latitude, longitude: position.longitude),
          16,
        ),
      );
    } catch (e) {
      debugPrint("Recenter failed: $e");
    }
  }

  Future<void> onCall(BuildContext context) async {
    final opened = await callPhoneNumber(order.customerMobile);
    if (!opened && context.mounted) {
      showErrorSnackBar("Unable to open the phone dialer", context);
    }
  }

  // Online orders go straight to OTP, COD orders confirm the cash first
  void onCloseDelivery() {
    if (order.isCod) {
      cashMode.value = null;
      paymentReceived.value = false;
      Get.bottomSheet(
        const CashCollectSheet(),
        isScrollControlled: true,
      ).then((_) => _paymentTimer?.cancel());
    } else {
      openVerifySheet();
    }
  }

  void selectCashMode(int mode) {
    if (paymentReceived.value) return;
    _paymentTimer?.cancel();
    cashMode.value = mode;
    if (mode == 0) {
      order.collectedVia = "In-hand";
      Get.back();
      openVerifySheet();
      return;
    }
    // TODO: replace this placeholder delay with the payment status api.
    _paymentTimer = Timer(const Duration(seconds: 5), () {
      paymentReceived.value = true;
      order.collectedVia = "Scan & Collect";
      _paymentTimer = Timer(const Duration(seconds: 2), () {
        Get.back();
        openVerifySheet();
      });
    });
  }

  void openVerifySheet() {
    // TODO: call send delivery OTP api here.
    otpController.clear();
    otp.value = "";
    startOtpTimer();
    Get.bottomSheet(
      const VerifyCloseSheet(),
      isScrollControlled: true,
      isDismissible: false,
    ).then((_) => _otpTimer?.cancel());
  }

  void startOtpTimer() {
    _otpTimer?.cancel();
    secondsLeft.value = 30;
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value == 0) {
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  void resendOtp() {
    // TODO: call resend delivery OTP api here.
    otpController.clear();
    otp.value = "";
    startOtpTimer();
    otpFocusNode.requestFocus();
  }

  Future<void> verifyAndClose() async {
    if (otp.value.length != 4) return;
    // TODO: call verify delivery OTP api here.
    otpFocusNode.unfocus();
    Get.back();
    // Let the sheet finish closing before this screen is replaced
    await Future.delayed(const Duration(milliseconds: 300));
    if (isClosed) return;
    Get.find<HomeController>().closeDelivery(order);
    Get.offNamed(AppRoutes.deliveryClosed, arguments: order);
  }

  Future<void> _cleanupRoute() async {
    if (!_sessionStarted) return;
    try {
      await GoogleMapsNavigator.stopGuidance();
      await GoogleMapsNavigator.clearDestinations();
      await GoogleMapsNavigator.cleanup();
    } catch (e) {
      debugPrint("Route cleanup failed: $e");
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _remainingSub?.cancel();
    _arrivalSub?.cancel();
    _positionSub?.cancel();
    WakelockPlus.disable();
    _cleanupRoute();
    _paymentTimer?.cancel();
    _otpTimer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }
}
