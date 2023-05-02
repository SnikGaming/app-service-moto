//172.19.176.1:3000/san-pham/search?page=3
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../network/connect.dart';
import '../../../../preferences/product/product.dart';
import 'models/products.dart';

class APIProduct {
  static List<Data> apiProducts = [];
  static Future<List<Data>> getData(
      // ignore: non_constant_identifier_names
      {int category_id = 1,
      int page = 1,
      String search = '',
      // ignore: non_constant_identifier_names
      int min_price = 0,
      // ignore: non_constant_identifier_names
      int max_price = 999999999}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://192.168.1.8:8000/api/products?category_id=$category_id&page=$page&search=$search&min_price=$min_price&max_price=$max_price"),
        // headers: {'Authorization': 'Bearer $token'}
      );
      final jsonData = json.decode(response.body);
      final List<dynamic> projectListJson = jsonData['data'];
      final total = jsonData['total_pages'];
      ProductPrefer.setTotal(value: projectListJson.isEmpty ? 0 : total);
      // print('data sp $total');
      // print('data sp $projectListJson');
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
