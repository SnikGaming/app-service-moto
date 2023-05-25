// ignore_for_file: file_names

import 'package:app/network/connect.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:dio/dio.dart';

class ApiBase {
  static final dio = Dio(
    BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        contentType: 'application/json'),
  );
  static Future<Response> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    return await dio.get("${ConnectDb.url}$path",
        options: Options(
            headers: {'Authorization': 'Bearer ${UserPrefer.getToken()}'}),
        queryParameters: queryParameters);
  }

  static Future<Response> post({required String path, dynamic data}) async {
    return await dio.post("${ConnectDb.url}$path",
        data: data,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${UserPrefer.getToken()}'
        }));
  }
}
