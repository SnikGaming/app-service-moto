// ignore_for_file: non_constant_identifier_names

import 'package:app/modules/home/api/APIBASE.dart';
import 'package:dio/dio.dart';

import 'package:app/preferences/product/product.dart';
import '../../../../network/connect.dart';
import 'models/products.dart';

class APIProduct {
  static List<Data> apiProducts = [];
  static Future<List<Data>> getData({
    int? category_id,
    int page = 1,
    String search = '',
    int min_price = 0,
    int max_price = 999999999,
  }) async {
    try {
      final response =
          await ApiBase.get(path: '/api/products/', queryParameters: {
        "category_id": category_id,
        "page": page,
        "search": search,
        "min_price": min_price,
        "max_price": max_price,
      });
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];
      final total = jsonData['total_pages'];
      ProductPrefer.setTotal(value: projectListJson.isEmpty ? 0 : total);
      final List<Data> projectList = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      apiProducts = projectList;
      return projectList;
    } catch (e) {
      return [];
    }
  }
}
