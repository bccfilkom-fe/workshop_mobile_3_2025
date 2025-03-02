import 'package:dio/dio.dart';
import 'package:todo_app_simple/core/constants/api_constants.dart';
import 'package:todo_app_simple/core/services/local_storage_service.dart';

class AuthServices {
  final localStorageService = LocalStorageService();
  final dio = Dio();

  //login
  Future<void> login(String email, String password) async {
    try {
      final response = await dio.post(ApiConstants.login,
          data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        final accessToken = response.data['data']['tokens']['accessToken'];
        final refreshToken = response.data['data']['tokens']['refreshToken'];

        await localStorageService.saveToken(accessToken, refreshToken);
      }
    } catch (e) {
      throw Exception("Gagal login: $e");
    }
  }

  //register
  Future<bool> register(String email, String password) async {
    try {
      final response = await dio.post(ApiConstants.register,
          data: {"email": email, "password": password});

      return response.data['success'] == true;
    } catch (e) {
      throw Exception("Gagal register: $e");
    }
  }

  //logout
  Future<void> logout() async {
    await localStorageService.clearToken();
  }

  //refresh token
  Future<void> refreshAccessToken() async {
    try {
      final refreshToken = await localStorageService.getRefreshToken();

      final response = await dio.post(ApiConstants.refreshToken, data: {
        "refreshToken": refreshToken,
      });

      if (response.statusCode == 200) {
        final accessToken = response.data['data']['tokens']['accessToken'];
        final refreshToken = response.data['data']['tokens']['refreshToken'];

        await localStorageService.saveToken(accessToken, refreshToken);
      }
    } catch (e) {
      throw Exception("Gagal merefresh token: $e");
    }
  }
}
