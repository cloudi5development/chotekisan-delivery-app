import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class DioClient {
  static Dio dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString("Token");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          options.headers["Accept"] = "application/json";
          options.headers["Content-Type"] = "application/json";

          return handler.next(options);
        },

        onResponse: (response, handler) async {
          // Case 1: API returns 401
          if (response.statusCode == 401 ||
              response.data?["message"] == "Unauthenticated.") {
            await _forceLogout();
          }

          return handler.next(response);
        },

        onError: (DioException error, handler) async {
          // Case 2: Dio throws 401 error
          if (error.response?.statusCode == 401 ||
              error.response?.data?["message"] == "Unauthenticated.") {
            await _forceLogout();
          }

          return handler.next(error);
        },
      ),
    );

  static Future<void> _forceLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
