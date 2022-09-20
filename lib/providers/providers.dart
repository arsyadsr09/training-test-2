import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project_logic/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Providers {
  static Future login(
      {required String? email, required String password}) async {
    return Dio().post('$HOST/login',
        data: {"email": email, "password": password},
        options: Options(
            headers: {"Autorization": headerHost},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future getUserById() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("USER_AUTH");

    Map decoded = JwtDecoder.decode(token!);
    String id = decoded['user_id'];

    return Dio().get('$HOST/users/$id',
        options: Options(
            headers: {"Authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }

  static Future getTransaction() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("USER_AUTH");

    Map decoded = JwtDecoder.decode(token!);
    String id = decoded['user_id'];

    return Dio().get('$HOST/transactions/$id',
        options: Options(
            headers: {"Authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 1000;
            }));
  }
}
