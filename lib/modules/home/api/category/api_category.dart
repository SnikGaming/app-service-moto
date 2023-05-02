//172.19.176.1:3000/san-pham/search?page=3
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';
import 'models/category.dart';

class APICategory {
  static List<Data> apiCategory = [];

  static Future<List<Data>> getData() async {
    print('data ');
    print('data loai ok');

    try {
      final response = await http.get(
        // Uri.parse("http://${ConnectDb.ip}:8000/api/categories/"),
        Uri.parse("http://192.168.1.8:8000/api/categories/"),

        // headers: {'Authorization': 'Bearer $token'}
      );
      final jsonData = json.decode(response.body);
      print('data loai try catch');

      final List<dynamic> projectListJson = jsonData['data'];
      print('data loai $projectListJson');

      final List<Data> data = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();

      apiCategory = data;
      return data;
    } catch (e) {
      print('data $e');

      return [];
    }
  }
}
