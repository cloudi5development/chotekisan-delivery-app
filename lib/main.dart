import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/routes/app_pages.dart';
import 'package:chotekisan_delivery_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// /// Top-level background message handler (must be a top-level function)
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("🔔 Background message received: ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp();

  // // Register background message handler
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // await NotificationService.init();
  // await requestNotificationPermission();

  // if (fcmToken != null) {
  //   print("FCM Token: $fcmToken");
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("FCMTOKEN", fcmToken);
  // }

  // // Check if notifications are enabled
  // final isEnabled = await NotificationService.checkNotificationEnabled();
  // print("🔔 Notification permission status: ${isEnabled ? 'ON' : 'OFF'}");

  // // Listen for foreground FCM messages and show local notification
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print("🔔 Foreground message received: ${message.messageId}");
  //   if (message.notification != null) {
  //     NotificationService.showNotification(
  //       title: message.notification!.title ?? 'Notification',
  //       body: message.notification!.body ?? '',
  //       payload: jsonEncode(message.data),
  //     );
  //   }
  // });

  // // When user taps notification while app is in background
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print("🔔 Notification tapped (background): ${message.messageId}");
  //   Get.toNamed(AppRoutes.notification);
  // });

  // // When app is opened from terminated state via notification tap
  // final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  // if (initialMessage != null) {
  //   print(
  //     "🔔 App opened from terminated via notification: ${initialMessage.messageId}",
  //   );
  //   // Delay navigation to let GetMaterialApp initialize first
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Get.toNamed(AppRoutes.notification);
  //   });
  // }

  runApp(const MyApp());
}

// Future<void> requestNotificationPermission() async {
//   if (await Permission.notification.isDenied) {
//     await Permission.notification.request();
//     print("Notification Permission Request");
//   } else {
//     print("Notification Permission Granted");
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'CHOTEKISAN DELIVERY APP',
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: widget ?? const SizedBox.shrink(),
          );
        },
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<MyColors>>[
            MyColors(
              txt: const Color(0XFF111827),
              primary: const Color(0xFFF27224),
              primaryText: const Color(0xFF6B7280),
              primaryLableText: const Color(0XFF2A2A2A),
              primaryLight: const Color(0xFFA61C1C),
              secondary: const Color(0xFFAD1D3D),
              accentTxt: const Color(0xFF001928),
              bg1: const Color(0xFFF5F5F5),
              bgColor: Colors.white,
              surface: Colors.white,
              error: const Color(0xFFd32f2f),
              //Extra
              bgGray: const Color(0xFFF0F8FD),
              litegray: const Color(0xffF6F6F6),
              darkGray: const Color(0xFF666666),
              lightGray: const Color(0xFF9A9A9A),
              borderGray: const Color(0xFFE6E8EA),
              textGray: const Color(0xFF5C5C5C),
              green: const Color(0xFF00A41E),
              white: Colors.white,
              whiteColor: Colors.white,
              blackText: const Color(0xFF222222),
              blackColor: const Color(0xff424242),
              contentColor: const Color(0xFF777777),
              borderColor: const Color(0xFFDDDDDD),
              greenColor: const Color(0xFF007306),
              // greenColor: const Color(0xFF009F0B),
              // greenColor: const Color(0xFF198754),
              darkContentColor: const Color(0xFFBABABA),
              ratingColor: const Color(0xffD18202),
              // ratingColor: const Color(0xffF7B92B),
              homeCategoryColor: const Color(0xFFFFFFFF),
              textColor: Colors.white,
              greyLight25: const Color(0xFFEDEFF4),
              pink: const Color(0xffFF8B8B),
              amber: Colors.amber,
            ),
          ],
        ),
        // darkTheme: ThemeData.dark().copyWith(
        //   extensions: <ThemeExtension<MyColors>>[
        //     MyColors(
        //       txt: Colors.white,
        //       primary: const Color(0xff3433C2),
        //       primaryLight: const Color(0xFFC8C8C8),
        //       primaryLableText: const Color(0xFF1F74BA),
        //       secondary: const Color(0xFF6EBAE7),
        //       accentTxt: const Color(0xFF001928),
        //       bg1: const Color(0xFF151A1E),
        //       bgColor: const Color(0xffF5F5F5),
        //       surface: const Color(0xFF151A1E),
        //       error: const Color(0xFFd32f2f),
        //       bgGray: const Color(0xFF262F36),
        //       litegray: const Color(0xFF999999),
        //       darkGray: const Color(0xFF999999),
        //       // lightGray: const Color(0xFF202020),
        //       borderGray: const Color(0xFF353C41),
        //       green: const Color(0xFF5CB85C),
        //       white: Colors.white,
        //       whiteColor: Colors.black,
        //       blackText: const Color(0xFF262626),
        //       blackColor: Colors.white,
        //       primaryText: Colors.white,
        //       contentColor: const Color(0xFF777777),
        //       borderColor: const Color(0xFFDDDDDD),
        //       greenColor: const Color(0xFF198754),
        //       darkContentColor: const Color(0xFFBABABA),
        //       ratingColor: const Color(0xFFFFBA49),
        //       textColor: const Color(0xFF636363),
        //       homeCategoryColor: const Color(0xFFEAEDF2),
        //       greyLight25: Colors.black,
        //       pink: const Color(0xffFF8B8B),
        //       lightGray: null,
        //     ),
        //   ],
        // ),
        themeMode: ThemeMode.system,
        getPages: AppPages.routes,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
