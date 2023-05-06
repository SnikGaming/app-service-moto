import 'dart:convert';

import 'package:app/modules/home/api/banner/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';

class APIBanner {
  static List<Data> apiBanner = [];
  static Future<List<Data>> getData() async {
    try {
      final response = await http.get(
        Uri.parse("${ConnectDb.url}/api/banners/"),

        // headers: {'Authorization': 'Bearer $token'}
      );
      final jsonData = json.decode(response.body);
      print('data ____ adasdas');

      final List<dynamic> projectListJson = jsonData['data'];
      print('data banner $projectListJson');

      final List<Data> data = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      print('data ____ ${data}');
      apiBanner = data;

      return data;
    } catch (e) {
      // print('data $e');

      return [];
    }
  }
}
