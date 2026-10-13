import 'package:chotekisan_delivery_app/Screen/Application_Status/application_status_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Application_Status/application_status_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Basic_Information/basic_information_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Basic_Information/basic_information_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Dashboard/dashboard_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Declaration/declaration_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Declaration/declaration_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Details/delivery_details_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Details/delivery_details_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Person_Type/delivery_person_type_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Delivery_Person_Type/delivery_person_type_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Document_Upload/document_upload_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Documents_Verification/documents_verification_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Documents_Verification/documents_verification_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Document_Upload/document_upload_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Faqs/faqs_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Faqs/faqs_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Help_Support/help_support_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Help_Support/help_support_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Incentives_Rewards/incentives_rewards_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Incentives_Rewards/incentives_rewards_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Login/login_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Login/login_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Manage_Profile/manage_profile_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Manage_Profile/manage_profile_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Message_Centre/message_centre_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Message_Centre/message_centre_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Notifications/notifications_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Notifications/notifications_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Otp/otp_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Otp/otp_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Payment_Information/payment_information_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Payment_Information/payment_information_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Refer_Earn/refer_earn_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Refer_Earn/refer_earn_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Slots/select_slots_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Slots/select_slots_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Zone/select_zone_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Select_Zone/select_zone_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Splash/splash_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Update_Vehicle_Details/update_vehicle_details_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Update_Vehicle_Details/update_vehicle_details_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Vehicle_Details/vehicle_details_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Vehicle_Details/vehicle_details_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Splash/splash_screen.dart';
import 'package:chotekisan_delivery_app/Screen/Vehicle_Information/vehicle_information_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Wrong_Actions/wrong_actions_binding.dart';
import 'package:chotekisan_delivery_app/Screen/Wrong_Actions/wrong_actions_screen.dart';
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
      name: AppRoutes.manageProfile,
      page: () => const ManageProfileScreen(),
      binding: ManageProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.messageCentre,
      page: () => const MessageCentreScreen(),
      binding: MessageCentreBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.wrongActions,
      page: () => const WrongActionsScreen(),
      binding: WrongActionsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.referEarn,
      page: () => const ReferEarnScreen(),
      binding: ReferEarnBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.vehicleDetails,
      page: () => const VehicleDetailsScreen(),
      binding: VehicleDetailsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.updateVehicleDetails,
      page: () => const UpdateVehicleDetailsScreen(),
      binding: UpdateVehicleDetailsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.documentsVerification,
      page: () => const DocumentsVerificationScreen(),
      binding: DocumentsVerificationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      binding: NotificationsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.helpSupport,
      page: () => const HelpSupportScreen(),
      binding: HelpSupportBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.faqs,
      page: () => const FaqsScreen(),
      binding: FaqsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.incentivesRewards,
      page: () => const IncentivesRewardsScreen(),
      binding: IncentivesRewardsBinding(),
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
