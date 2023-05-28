import 'dart:convert';

import 'package:app/modules/home/api/order/order.dart' as order;

import '../APIBASE.dart';

class APIOrder {
  static List<order.Data> lsData = [];

  static Future<List<order.Data>> fetchOrder() async {
    try {
      final response = await ApiBase.get(path: '/api/orders/');
      final jsonData = json.decode(response.toString());
      final List<dynamic> dataListJson = jsonData['data'];
      var toTal = jsonData['last_page'];
      final List<order.Data> Order = dataListJson
          .map((dataJson) => order.Data.fromJson(dataJson))
          .toList();
      lsData = Order;
      print('location data ---> ${lsData[0].product![0].id}');
      return Order;
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic> fetchOrderStatus() async {
    try {
      final response = await ApiBase.get(path: '/api/orders_status/');
      final jsonData = json.decode(response.toString());

      return jsonData['data'];
    } catch (e) {
      print('Order --> orders_status []');
      return null;
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
}
