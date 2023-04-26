//172.19.176.1:3000/san-pham/search?page=3
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';
import 'models/products.dart';

class APIProduct {
  static List<Data> apiProducts = [];
  static Future<List<Data>> getData({int? page}) async {
    print('data ');
    try {
      if (page == null) {
        page = 1;
      }
      final response = await http.get(
        Uri.parse("http://${ConnectDb.ip}:3000/san-pham/search?page=$page"),
        // headers: {'Authorization': 'Bearer $token'}
      );
      final jsonData = json.decode(response.body);
      print('data ');

      final List<dynamic> projectListJson = jsonData['data'];
      print('data $projectListJson');

      final List<Data> projectList = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();

      apiProducts = projectList;
      return projectList;
    } catch (e) {
      print('data $e');

      return [];
    }
  }
}
