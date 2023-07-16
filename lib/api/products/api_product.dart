// ignore_for_file: non_constant_identifier_names

import 'package:app/api/APIBASE.dart';

import 'package:app/preferences/product/product.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'models/products.dart';

class APIProduct {
  static List<Data> apiProducts = [];
  static List<Data> kqSearch = [];

  static List<Data> dataOrder = [];

  static create({required String id}) async {
    final value = {'product_id': id};
    try {
      final response = await ApiBase.post(path: '/api/favorites', data: value);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      return 401;
    }
  }

  static Future<List<Data>> getData(
      {int? category_id,
      int page = 1,
      String search = '',
      int min_price = 0,
      int max_price = 999999999,
      int tag = 2}) async {
    String link = '/api/products';
    try {
      if (UserPrefer.getToken() != null) {
        link = '/api/sp';
      }
      final response = await ApiBase.get(path: link, queryParameters: {
        "category_id": category_id,
        "page": page,
        "search": search,
        "min_price": min_price,
        "max_price": max_price,
        "tag": tag
      });
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];
      final total = jsonData['total_pages'];
      ProductPrefer.setTotal(value: projectListJson.isEmpty ? 0 : total);
      final List<Data> projectList = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      apiProducts = projectList;
      print('data products $jsonData');
      return projectList;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Data>> search(
      {String search = '',
      int min_price = 0,
      int max_price = 999999999,
      int tag = 2}) async {
    String link = '/api/products/appsearch';
    try {
      final response = await ApiBase.get(path: link, queryParameters: {
        "search": search,
        "min_price": min_price,
        "max_price": max_price,
        "tag": tag
      });
      final jsonData = response.data;
      final List<dynamic> projectListJson = jsonData['data'];
      // final total = jsonData['total_pages'];
      // ProductPrefer.setTotal(value: projectListJson.isEmpty ? 0 : total);
      final List<Data> projectList = projectListJson
          .map((projectJson) => Data.fromJson(projectJson))
          .toList();
      kqSearch = projectList;
      print('data products $jsonData');
      return projectList;
    } catch (e) {
      return [];
    }
  }

  // static Future<List<Data>> getDataById({required List<int> data}) async {
  //   try {
  //     final response = await ApiBase.post(
  //       path: '/api/getProductById/',
  //       data: {"product_ids": data},
  //     );

  //     final jsonData = response.data;
  //     print('data products af $jsonData');
  //     final List<dynamic> projectListJson = jsonData['data'];

  //     final List<Data> projectList = projectListJson
  //         .map((projectJson) => Data.fromJson(projectJson))
  //         .toList();
  //     dataOrder = projectList;
  //     return projectList;
  //   } catch (e) {
  //     return [];
  //   }
  // }
}
