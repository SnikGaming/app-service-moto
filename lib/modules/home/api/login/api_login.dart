import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';

class APIAuth {
  static Future<int> login(
      {String email = "long@gmail.com", String password = "12345678"}) async {
    try {
      final response = await Dio().post(
        "${ConnectDb.url}/api/login",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final String tempToken = responseData['token'];
        final token = extractToken(tempToken);
        UserPrefer.setToken(value: token!);
        return 200;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      // throw Exception(e.toString());
      return 400;
    }
  }
}

String? extractToken(String bearerToken) {
  final parts = bearerToken.split(' ');
  return parts.length == 2 ? parts[1] : null;
}
