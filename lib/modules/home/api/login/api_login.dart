import 'dart:convert';

import 'package:app/modules/home/api/login/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../network/connect.dart';
import '../../../../preferences/user/user_preferences.dart';

class APIAuth {
  static Data userLogin = Data();

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
        getUser();
        return 200;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      // throw Exception(e.toString());
      return 400;
    }
  }

  static Future<Data?> getUser() async {
    // print('this is user ');
    Response response;
    try {
      response = await Dio().get(
        "${ConnectDb.url}/api/user/",
        options: Options(
          headers: {'Authorization': 'Bearer ${UserPrefer.getToken()}'},
        ),
      );
    } catch (e) {
      return null;
    }
    final jsonData = response.data['data'];
    print('this is user ${Data.fromJson(jsonData).email}');
    saveUserData(jsonData);
    return Data.fromJson(jsonData);
  }

  static void saveUserData(Map<String, dynamic> jsonData) {
    UserPrefer.setEmail(value: jsonData['email']);
    UserPrefer.setImageUser(value: jsonData['image']);
    UserPrefer.setUserName(value: jsonData['name']);
    UserPrefer.setId(value: jsonData['id']);
  }
}

String? extractToken(String bearerToken) {
  final parts = bearerToken.split(' ');
  return parts.length == 2 ? parts[1] : null;
}
