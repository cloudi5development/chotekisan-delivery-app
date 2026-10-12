// import 'dart:convert';
// import 'dart:io'; 
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   static const String _channelId = 'download_channel';
//   static const String _generalChannelId = 'general_channel';

//   /// Check if notifications are enabled at the OS level
//   static Future<bool> checkNotificationEnabled() async {
//     final settings = await FirebaseMessaging.instance.getNotificationSettings();
//     final enabled =
//         settings.authorizationStatus == AuthorizationStatus.authorized;
//     print(enabled ? '✅ Notifications are ON' : '❌ Notifications are OFF');
//     return enabled;
//   }

//   static Future<void> init() async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings settings = InitializationSettings(
//       android: androidSettings,
//     );

//     await _plugin.initialize(
//       settings: settings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         print("🔔 Local notification tapped, payload: ${response.payload}");
//         if (response.payload == 'gallery') {
//           _openGallery();
//         } else if (response.payload != null && response.payload!.isNotEmpty) {
//           // Parse the payload string back to a map and extract the 'id'
//           try {
//             final Map<String, dynamic> data = jsonDecode(response.payload!);
//             print("📦 Parsed notification data: $data");
//             final int? notificationId = int.tryParse(data['id'].toString());
//             if (notificationId != null && notificationId > 0) {
//               print(
//                 "✅ Navigating to notification details with ID: $notificationId",
//               );
//               // Get.toNamed(
//               //   AppRoutes.notificationDetails,
//               //   arguments: notificationId,
//               // );
//             } else {
//               print("❌ Invalid notification ID in payload: ${data['id']}");
//             }
//           } catch (e) {
//             print("❌ Error parsing notification payload: $e");
//           }
//         }
//       },
//     );
//   }

//   static Future<void> showNotification({
//     required String title,
//     required String body,
//     String payload = 'notification',
//   }) async {
//     final AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//           _generalChannelId,
//           'General Notifications',
//           channelDescription: 'This channel is used for general notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//         );

//     await _plugin.show(
//       id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//       title: title,
//       body: body,
//       notificationDetails: NotificationDetails(android: androidDetails),
//       payload: payload,
//     );
//   }

//   static Future<void> _openGallery() async {
//     if (Platform.isAndroid) {
//       final Uri uri = Uri.parse("content://media/external/images/media");
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri);
//       } else {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       }
//     }
//   }

//   /// 🔽 Download Started
//   static Future<void> showDownloading(String message) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//           _channelId,
//           'Downloads',
//           channelDescription: 'File download notifications',
//           importance: Importance.high,
//           priority: Priority.high,
//           ongoing: true,
//           autoCancel: false,
//           indeterminate: true,
//         );

//     await _plugin.show(
//       id: 100,
//       title: 'Downloading',
//       body: message,
//       notificationDetails: const NotificationDetails(android: androidDetails),
//     );
//   }

//   /// ✅ Download Completed
//   static Future<void> showCompleted() async {
//     final AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//           _channelId,
//           'Downloads',
//           channelDescription: 'File download notifications',
//           importance: Importance.high,
//           priority: Priority.high,
//           ongoing: false,
//           autoCancel: true,
//         );

//     await _plugin.show(
//       id: 100,
//       title: 'Download completed',
//       body: 'Saved to device',
//       notificationDetails: NotificationDetails(android: androidDetails),
//       payload: 'gallery',
//     );
//   }
// }
