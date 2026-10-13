import 'package:chotekisan_delivery_app/Screen/Application_Status/application_status_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Application_Status/application_status_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Basic_Information/basic_information_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Basic_Information/basic_information_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Day_Earnings/day_earnings_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Day_Earnings/day_earnings_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Declaration/declaration_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Declaration/declaration_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Details/delivery_details_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Details/delivery_details_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Person_Type/delivery_person_type_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Person_Type/delivery_person_type_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Document_Upload/document_upload_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Document_Upload/document_upload_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Login/login_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Login/login_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Otp/otp_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Otp/otp_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Payment_Information/payment_information_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Payment_Information/payment_information_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Closed/delivery_closed_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Closed/delivery_closed_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Order_Details/order_details_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Order_Details/order_details_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Slots/select_slots_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Slots/select_slots_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Zone/select_zone_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Zone/select_zone_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Splash/splash_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Splash/splash_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Vehicle_Information/vehicle_information_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Vehicle_Information/vehicle_information_screen.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    // Home and Deliveries are tabs inside the dashboard
    GetPage<dynamic>(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.orderDetails,
      page: () => const OrderDetailsScreen(),
      binding: OrderDetailsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.dayEarnings,
      page: () => const DayEarningsScreen(),
      binding: DayEarningsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.deliveryClosed,
      page: () => const DeliveryClosedScreen(),
      binding: DeliveryClosedBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.selectSlots,
      page: () => const SelectSlotsScreen(),
      binding: SelectSlotsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.selectZone,
      page: () => const SelectZoneScreen(),
      binding: SelectZoneBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.deliveryDetails,
      page: () => const DeliveryDetailsScreen(),
      binding: DeliveryDetailsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.basicInformation,
      page: () => const BasicInformationScreen(),
      binding: BasicInformationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.vehicleInformation,
      page: () => const VehicleInformationScreen(),
      binding: VehicleInformationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.documentUpload,
      page: () => const DocumentUploadScreen(),
      binding: DocumentUploadBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.paymentInformation,
      page: () => const PaymentInformationScreen(),
      binding: PaymentInformationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.declaration,
      page: () => const DeclarationScreen(),
      binding: DeclarationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.applicationStatus,
      page: () => const ApplicationStatusScreen(),
      binding: ApplicationStatusBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.deliveryPersonType,
      page: () => const DeliveryPersonTypeScreen(),
      binding: DeliveryPersonTypeBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
