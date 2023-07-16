import 'dart:convert';

import 'package:app/api/order/order.dart' as order;

import '../APIBASE.dart';

class APIOrder {
  static List<order.Data> lsData = [];

  static Future<List<order.Data>> fetchOrder({int? status}) async {
    try {
      String path = '/api/orders';
      if (status != null) {
        path += '?status=$status';
      }

      final response = await ApiBase.get(path: path);
      final jsonData = json.decode(response.toString());
      final List<dynamic> dataListJson = jsonData['data'];
      var toTal = jsonData['last_page'];
      final List<order.Data> Order = dataListJson
          .map((dataJson) => order.Data.fromJson(dataJson))
          .toList();
      lsData = Order;
      return Order;
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic> fetchOrderStatus() async {
    try {
      final response = await ApiBase.get(path: '/api/orders_status');
      final jsonData = json.decode(response.toString());

      return jsonData['data'];
    } catch (e) {
      return [];
    }
  }

  static Future<int> addOrder({required String json}) async {
    try {
      final response =
          await ApiBase.post(path: '/api/orderDetails', data: json);
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
        // throw Exception("Failed to login");
      }
    } catch (e) {
      return 400;
    }
  }

  static Future<int> huy({required String id}) async {
    try {
      final response = await ApiBase.post(path: '/api/huy/$id');
      if (response.statusCode == 200) {
        return 200;
      } else {
        return 400;
        // throw Exception("Failed to login");
      }
    } catch (e) {
      return 400;
    }
  }
}
