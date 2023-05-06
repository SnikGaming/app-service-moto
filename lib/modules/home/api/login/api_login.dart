import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';

String? extractToken(String bearerToken) {
  final parts = bearerToken.split(' ');
  return parts.length == 2 ? parts[1] : null;
}

Future login(
    {String email = "long@gmail.com", String password = "12345678"}) async {
  try {
    final response = await http.post(
      Uri.parse("${ConnectDb.url}/api/login"),
      body: {
        "email": email,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
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
