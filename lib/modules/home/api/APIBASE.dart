import 'package:app/network/connect.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:dio/dio.dart';

class ApiBase {
  static Future<Response> get(String path) async {
    return await Dio().get("${ConnectDb.url}$path",
        options: Options(
            headers: {'Authorization': 'Bearer ${UserPrefer.getToken()}'}));
  }

  static Future<Response> post(String path, dynamic data) async {
    return await Dio().post("${ConnectDb.url}$path",
        data: data,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${UserPrefer.getToken()}'
        }));
  }
}
