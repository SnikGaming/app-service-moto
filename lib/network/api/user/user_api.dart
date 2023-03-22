import 'dart:convert';

import 'package:app/components/message/message.dart';
import 'package:app/modules/app_constants.dart';
import 'package:app/network/connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../../../preferences/user/user_preferences.dart';

class UserAPI extends ConnectDb {
  static Login({
    required String username,
    required String password,
  }) async {
    var _connect = ConnectDb.ip + "users/login";
    Map<String, String> _data = {"username": username, "password": password};

    final _response = await http.post(
      Uri.parse(_connect),
      body: _data,
    );
    if (_response.statusCode == 200 || _response.statusCode == 201) {
      final parsed = json.decode(_response.body);
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
    var _connect = ConnectDb.ip + "users/register";
    Map<String, String> _data = {
      // "username": username,
      "email": email,
      "password": password,
      "confirmpassword": repassword, 'status': '0'
    };
    final _response = await http.post(
      Uri.parse(_connect),
      body: _data,
    );

    final parsed = json.decode(_response.body);
    // print(parsed);
    if (parsed == false) {
      Message.error(message: 'Khong thanh cong', context: context);
      return 404;
    } else {
      UserPrefer.setEmail(value: email);
      Message.success(message: "Hello $email", context: context);
      return 200;
    }
  }
}
