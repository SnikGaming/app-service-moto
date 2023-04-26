//172.19.176.1:3000/san-pham/search?page=3
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';
import 'models/category.dart';

class APICategory {
  static List<Data> apiCategory = [];

  static Future<List<Data>> getData() async {
    print('data ');

    try {
      final response = await http.get(
        Uri.parse("http://${ConnectDb.ip}:3000/loai-san-pham/"),
        // headers: {'Authorization': 'Bearer $token'}
      );
      final jsonData = json.decode(response.body);
      print('data ');

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
