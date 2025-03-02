import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_simple/core/constants/api_constants.dart';
import 'package:todo_app_simple/core/services/local_storage_service.dart';

class UserServices {
  final dio = Dio();
  final localStorageServices = LocalStorageService();

  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";

  Future<String?> getUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(accessTokenKey);

      if (token == null) {
        throw Exception("Access token tidak ditemukan");
      }

      final response = await dio.get(ApiConstants.getCurrentUser,
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        return response.data['data']['email'];
      } else {
        throw Exception("Gagal mengambil data!");
      }
    } catch (e) {
      throw Exception("Gagal mengambil data, $e");
    }
  }
}
