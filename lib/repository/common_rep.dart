import 'package:chotekisan_delivery_app/repository/common_rep.dart' as DioClient;
import 'package:dio/dio.dart';
final Dio dio = DioClient.dio;

class ApiRepo {
  // Future<AboutUsModel> aboutUsApi() async {
  //   try {
  //     final String url = "${EndPoints.baseUrl}about-us";
  //     final response = await dio.get(
  //       url,
  //       options: Options(
  //         validateStatus: (status) => status! < 500,
  //         followRedirects: false,
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json",
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       print("Success Response: ${response.data}");
  //       return AboutUsModel.fromJson(response.data);
  //     } else {
  //       print("Failure Response: ${response.data}");
  //       return AboutUsModel.fromJson(response.data);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<StudentDetailsModel> selectStudentApi(
  //   Map<String, dynamic> body,
  // ) async {
  //   final String url = "${EndPoints.baseUrl}students/selected";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("BearerToken");
  //   print("Bearer Token : $token");
  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: body,
  //       options: Options(
  //         followRedirects: false,
  //         validateStatus: (status) => (status)! < 500,
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Accept": "application/json",
  //           "Authorization": "Bearer $token",
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       print("Success Response:${response.data}");
  //       return StudentDetailsModel.fromJson(response.data);
  //     } else {
  //       print("Failure Response:${response.data}");
  //       return StudentDetailsModel.fromJson(response.data);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
