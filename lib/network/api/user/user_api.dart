import 'dart:convert';

import 'package:app/components/message/message.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/network/connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../../../preferences/user/user_preferences.dart';

class UserAPI extends ConnectDb {
  // ignore: non_constant_identifier_names
  static Login({
    required String username,
    required String password,
  }) async {
    var connect = "${ConnectDb.ip}users/login";
    Map<String, String> data = {"username": username, "password": password};

    final response = await http.post(
      Uri.parse(connect),
      body: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final parsed = json.decode(response.body);
      UserPrefer.setToken(value: parsed['data']['access_token']);
      await UserPrefer.setEmail(value: username);
      Modular.to.navigate(Routes.home);
      return 200;
    }
  }

  static register(
      {
      // required String username,
      required email,
      required password,
      required repassword,
      required BuildContext context}) async {
    var connect = "${ConnectDb.ip}users/register";
    Map<String, String> data = {
      // "username": username,
      "email": email,
      "password": password,
      "confirmpassword": repassword, 'status': '0'
    };
    final response = await http.post(
      Uri.parse(connect),
      body: data,
    );

    final parsed = json.decode(response.body);
    // print(parsed);
    if (parsed == false) {
      // ignore: use_build_context_synchronously
      Message.error(message: 'Khong thanh cong', context: context);
      return 404;
    } else {
      UserPrefer.setEmail(value: email);
      // ignore: use_build_context_synchronously
      Message.success(message: "Hello $email", context: context);
      return 200;
    }
  }
}
