import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../preferences/user/user_preferences.dart';

String? extractToken(String bearerToken) {
  final parts = bearerToken.split(' ');
  return parts.length == 2 ? parts[1] : null;
}

Future login(
    {String email = "long@gmail.com", String password = "12345678"}) async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.1.8:8000/api/login"),
      body: {
        "email": email,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String tempToken = responseData['token'];
      print('token $tempToken');
      final token = extractToken(tempToken);
      print('token $token');
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
